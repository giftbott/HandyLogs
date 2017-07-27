// MIT License
//
// Copyright (c) 2017 giftbott (giftbott@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

// TODO: changeable timestamp formatt

public struct Handy {
  private init() {}
  
  public enum Level {
    case info, check, debug, warning, error, fatal
    
    /// defaultLevel for log function
    public static var `default`: Level = .info
    
    fileprivate var name: String {
      switch self {
      case .info:     return "Info "
      case .check:    return "Check"
      case .debug:    return "Debug"
      case .warning:  return "Warn "
      case .error:    return "Error"
      case .fatal:    return "Fatal"
      }
    }
    
    /// Alterable emojis
    ///
    ///     Handy.Level.infoEmoji = "✳️"
    public static var infoEmoji: String = "✳️"
    public static var checkEmoji: String = "☑️"
    public static var debugEmoji: String = "🔥"
    public static var warningEmoji: String = "⚠️"
    public static var errorEmoji: String = "❌"
    public static var fatalEmoji: String = "🆘"
    
    fileprivate var image: String {
      switch self {
      case .info:     return Level.infoEmoji
      case .check:    return Level.checkEmoji
      case .debug:    return Level.debugEmoji
      case .warning:  return Level.warningEmoji
      case .error:    return Level.errorEmoji
      case .fatal:    return Level.fatalEmoji
      }
    }
  }
  
  // MARK: PrintOption
  
  public struct PrintOption {
    private init() {}
    
    public enum Mode {
      case `default`
      case short
    }
    
    /// When enableLogging is false, Log don't be printed
    public static var enableLogging: Bool = true
    public static var printMode: Mode = .default
    
    /// Alterable emojis
    ///
    ///     Handy.PrintOption.timestampEmoji = "⏱"
    public static var timestampEmoji: String = "⏱"
    public static var executedLineEmoji: String = "➡️"
    public static var mainThreadEmoji: String?
    public static var backgroundThreadEmoji: String?
    
    /// Division Line Emoji
    public static var divisionLineEmoji: String = "="
    public static var repeatDivisionLineCharacter = 80
    
    /// if true, print log contents under base metadata message
    public static var isPrintAtNewLine: Bool = false
    
    /// Default thread message is (UI) for main thread & (BG) for background thread
    // No available for now.
    // public static var isPrintThread: Bool = true
  }
  
  
  /// Basic log function
  ///
  ///     Handy.log(somethingForLogging)
  ///
  /// or input Level you want
  ///
  ///     Handy.log(somethingForLogging, .error)
  ///
  /// defaultLevel is .info, if Level is omitted
  public static func m(
    _ objects: Any...,
    Level: Level = Level.default,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(Level, filename, line, funcname, objects)
  }
  
  /// Real printLog function
  
  private static func printLog(
    _ Level: Level,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function,
    _ objects: Array<Any>
    ) {
    guard PrintOption.enableLogging else { return }
    
    DispatchQueue.global().sync {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm:ss:SSS"
      let timestamp = dateFormatter.string(from: Date())
      let file = URL(string: filename)?.lastPathComponent.components(separatedBy: ".").first ?? "Unknown"
      let queue = Thread.isMainThread ?
        PrintOption.mainThreadEmoji ?? "(UI) " :
        PrintOption.backgroundThreadEmoji ?? "(BG) "
      
      var logString = ""
      switch Handy.PrintOption.printMode {
      case .default:
        logString = "\(Level.image)\(Level.name) "
          + "\(PrintOption.timestampEmoji)\(timestamp) "
          + "\(queue)"
          + "\(PrintOption.executedLineEmoji)\(file).\(funcname) (\(line))"
          + "\(Level.image)"
      case .short:
        logString = "\(Level.image)\(timestamp) \(queue)\(PrintOption.executedLineEmoji)\(file).\(funcname) (\(line))\(Level.image)"
      }
      
      let delimeter = PrintOption.isPrintAtNewLine ? "\n" : " "
      let message = objects.map { String(describing: $0) }.joined(separator: " ")
      
      print(logString + delimeter + message)
    }
  }
  
  // MARK: Subdevided Functions
  
  /// Handy.info(somethingForLogging)
  public static func info(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.info, filename, line, funcname, objects)
  }
  
  /// Handy.check(somethingForLogging)
  public static func check(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.check, filename, line, funcname, objects)
  }
  
  /// Handy.debug(somethingForLogging)
  public static func debug(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.debug, filename, line, funcname, objects)
  }
  
  /// Handy.warning(somethingForLogging)
  public static func warning(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.warning, filename, line, funcname, objects)
  }
  
  /// Handy.error(somethingForLogging)
  public static func error(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.error, filename, line, funcname, objects)
  }
  
  /// Handy.fatal(somethingForLogging)
  public static func fatal(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.fatal, filename, line, funcname, objects)
  }
}

// MARK: - Division Line

extension Handy {
  public static func addDivisionLine() {
    guard PrintOption.enableLogging else { return }
    
    let divisionLineString = String(repeating: PrintOption.divisionLineEmoji,
                                    count: PrintOption.repeatDivisionLineCharacter)
    print("\n" + divisionLineString + "\n")
  }
}


// MARK: - Description

extension Handy {
  
  /// Print all properties of class
  ///
  ///     Handy.description(someClassInstance)
  ///     Handy.description(someStruct)
  public static func description(_ object: Any) {
    guard PrintOption.enableLogging else { return }
    
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
}
