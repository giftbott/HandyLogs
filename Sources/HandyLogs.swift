// MIT License
//
// Copyright (c) 2023 Fourenn
//

import Foundation

public struct HandyLog {

  public init() {}

  public var configuration: Configuration = .init()

  /// logger.m(somethingForLogging)
  public func m(
    _ objects: Any...,
    level: Level = Configuration.defaultLevel,
    _ header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(level, filename, line, funcname, header, objects)
  }

  /// logger.debug(somethingForLogging)
  public func debug(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.debug, filename, line, funcname, header, objects)
  }

  /// logger.info(somethingForLogging)
  public func info(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.info, filename, line, funcname, header, objects)
  }

  /// logger.check(somethingForLogging)
  public func check(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.check, filename, line, funcname, header, objects)
  }

  /// logger.warning(somethingForLogging)
  public func warning(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.warning, filename, line, funcname, header, objects)
  }

  /// logger.error(somethingForLogging)
  public func error(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.error, filename, line, funcname, header, objects)
  }

  /// logger.fatal(somethingForLogging)
  public func fatal(
    _ objects: Any...,
    header: String = "",
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function
  ) {
    printLog(.fatal, filename, line, funcname, header, objects)
  }

  /// add divider
  ///
  /// 'separator' * 'repeatCount'
  ///
  /// e.g
  ///
  ///     ================================
  public func addDivider() {
    guard configuration.enableLogging else { return }
    let separator = String(
      repeating: configuration.separator.character,
      count: configuration.separator.repeatCount
    )
    print("\n" + separator + "\n")
  }

  /// Print all properties of class
  ///
  ///     logger.objectDescription(someInstance)
  public func objectDescription(_ object: Any) {
    guard configuration.enableLogging else { return }

    var description = "\n✨ \(type(of: object)) "
    description += "<\(Unmanaged.passUnretained(object as AnyObject).toOpaque())> ✨\n"

    let selfMirror = Mirror(reflecting: object)
    for child in selfMirror.children {
      if let propertyName = child.label {
        description += "👉 \(propertyName): \(child.value)\n"
      }
    }

    if let superMirror = selfMirror.superclassMirror {
      for child in superMirror.children {
        if let propertyName = child.label {
          description += "👉 \(propertyName): \(child.value)\n"
        }
      }
    }

    print(description)
  }

  private func printLog(
    _ level: Level,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function,
    _ header: String = "",
    _ objects: Array<Any>
  ) {
    guard configuration.enableLogging,
          level >= configuration.logLevelLimit,
          !configuration.bannedLogLevel.contains(level)
    else { return }

    let timestamp = configuration.dateFormatter.string(from: Date())
    let fileUrl = URL(fileURLWithPath: filename, isDirectory: false)
    let file = fileUrl.lastPathComponent.components(separatedBy: ".").first ?? "Unknown"
    let queue = Thread.isMainThread
    ? configuration.emoji.mainThread
    : configuration.emoji.backgroundThread

    let metadata = "\(level.emoji)\(timestamp) \(queue) \(configuration.emoji.executedLine)\(file).\(funcname) (\(line))\(level.emoji)"

    let delimeter = configuration.startFromNewLine ? "\n" : " "
    let header = header.isEmpty ? "" : header + " : "
    let message = objects.map { String(describing: $0) }.joined(separator: " ")

    print(metadata + delimeter + header + message)
  }
}

// MARK: - Configuration

extension HandyLog {
  public struct Configuration {

    /// Default log level for logger.m method
    public static var defaultLevel: Level = .info

    public var defaultLevel: Level {
      get { Configuration.defaultLevel }
      set { Configuration.defaultLevel = newValue }
    }

    /// Emojis for each log level
    fileprivate static var emoji: Emoji = .init()

    public var emoji: Emoji { Configuration.emoji }
    public func setCustomEmoji(_ emoji: Emoji) {
      Configuration.emoji = emoji
    }

    /// If enableLogging is false, no log is output
    public var enableLogging: Bool = true

    /// Only log levels equal to or greater than logLevelLimit will be output.
    /// default is "info" which prints all except debug level.
    ///
    /// - debug
    /// - info
    /// - check
    /// - warning
    /// - error
    /// - fatal
    public var logLevelLimit: Level = .info

    /// Included log levels will be not output
    public var bannedLogLevel: [Level] = []

    /// Log will be output from the next line, if true
    public var startFromNewLine: Bool = false

    /// separator characters for divider line
    public var separator: Separator = .init()

    /// log timestamp dateFormatter
    public var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm:ss"
      return dateFormatter
    }()
  }
}

extension HandyLog {
  public enum Level: Comparable {
    case debug
    case info
    case check
    case warning
    case error
    case fatal

    public var name: String {
      switch self {
      case .debug:    return "Debug"
      case .info:     return "Info "
      case .check:    return "Check"
      case .warning:  return "Warn "
      case .error:    return "Error"
      case .fatal:    return "Fatal"
      }
    }

    fileprivate var emoji: String {
      switch self {
      case .debug:    return HandyLog.Configuration.emoji.debug
      case .info:     return HandyLog.Configuration.emoji.info
      case .check:    return HandyLog.Configuration.emoji.check
      case .warning:  return HandyLog.Configuration.emoji.warning
      case .error:    return HandyLog.Configuration.emoji.error
      case .fatal:    return HandyLog.Configuration.emoji.fatal
      }
    }
  }

  public struct Emoji {
    // log level
    var debug: String = "🔥"
    var info: String = "✳️"
    var check: String = "☑️"
    var warning: String = "⚠️"
    var error: String = "❌"
    var fatal: String = "🆘"

    // thread
    var mainThread: String = "(UI)"
    var backgroundThread: String = "(BG)"

    // assist
    var executedLine: String = "➡️"
  }

  public struct Separator {
    var character: String = "="
    var repeatCount = 80
  }
}
