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

public struct Handy {
    
    /// When enableLogging is false, Log don't be printed
    public static var enableLogging: Bool = true
    
    public enum LogType {
        case info, check, debug, warning, error, fatal
        
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
        ///     Handy.LogType.infoEmoji = "✳️"
        public static var infoEmoji: String = "✳️"
        public static var checkEmoji: String = "☑️"
        public static var debugEmoji: String = "🔥"
        public static var warningEmoji: String = "⚠️"
        public static var errorEmoji: String = "❌"
        public static var fatalEmoji: String = "🆘"
        
        fileprivate var image: String {
            switch self {
            case .info:     return LogType.infoEmoji
            case .check:    return LogType.checkEmoji
            case .debug:    return LogType.debugEmoji
            case .warning:  return LogType.warningEmoji
            case .error:    return LogType.errorEmoji
            case .fatal:    return LogType.fatalEmoji
            }
        }
    }
    
    
    /// defaultLogType for log function
    public static var defaultLogType: LogType = .info
    
    
    /// Basic log function
    ///
    ///     Handy.log(somethingForLogging)
    ///
    /// or input logType you want
    ///
    ///     Handy.log(somethingForLogging, .error)
    ///
    /// defaultLogType is .info, if logtype is omitted
    public static func log(
        _ objects: Any...,
        logType: LogType = defaultLogType,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(logType, filename, line, funcname, objects)
    }
    
    
    //TODO: choice log string: timestamp, funcname, queue
    //TODO: changeable timestamp formatt, timestamp emoji, funcname emoji
    
    /// Real printLog function
    fileprivate static func printLog(
        _ logType: LogType,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        _ objects: Array<Any>)
    {
        if enableLogging {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss:SSS"
            let timestamp = dateFormatter.string(from: Date())
            let file = URL(string: filename)?.lastPathComponent.components(separatedBy: ".").first ?? "Unknown"
            let queue = Thread.isMainThread ? "UI" : "BG"
            
            print("\(logType.image)\(logType.name)", terminator: " ")
            print("⏱\(timestamp) \(file) (\(queue))", terminator: " ")
            print("⚙️\(funcname) (\(line)) \(logType.image)", terminator: " ")
            let _ = objects.map { print($0, terminator: " ") }
            print()
        }
    }
    
}


//MARK: Subdevided Functions
extension Handy {
    
    /// Handy.cLog(somethingForLogging)
    public static func cLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.check, filename, line, funcname, objects)
    }
    
    /// Handy.dLog(somethingForLogging)
    public static func dLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.debug, filename, line, funcname, objects)
    }
    
    /// Handy.wLog(somethingForLogging)
    public static func wLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.warning, filename, line, funcname, objects)
    }
    
    /// Handy.eLog(somethingForLogging)
    public static func eLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.error, filename, line, funcname, objects)
    }
    
    /// Handy.fLog(somethingForLogging)
    public static func fLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.fatal, filename, line, funcname, objects)
    }
}


//MARK: Description Function
extension Handy {
    
    /// Print all properties of class
    ///
    ///     Handy.description(someViewController)
    ///     Handy.description(someModel)
    public static func description(_ object: Any) {
        if enableLogging {
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
}
