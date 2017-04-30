//
//  HandyLogs.swift
//  HandyLogs
//
//  Created by giftbot on 2017. 4. 30..
//  Copyright © 2017년 giftbot. All rights reserved.
//

import Foundation

public struct Handy {
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
    
    private static func printLog(
        _ logType: LogType,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        _ objects: Array<Any>)
    {
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
    
    #if !SUBDIVIDE
    public static var defaultLogType: LogType = .info
    
    public static func log(
        _ objects: Any...,
        logType: LogType = defaultLogType,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(logType, filename, line, funcname, objects)
    }
    #endif
    
    #if SUBDIVIDE
    public static func log(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.info, filename, line, funcname, objects)
    }
    
    public static func cLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.check, filename, line, funcname, objects)
    }
    
    public static func dLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.debug, filename, line, funcname, objects)
    }
    
    public static func wLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.warning, filename, line, funcname, objects)
    }
    
    public static func eLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.error, filename, line, funcname, objects)
    }
    
    public static func fLog(
        _ objects: Any...,
        _ filename: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function)
    {
        printLog(.fatal, filename, line, funcname, objects)
    }
    #endif
}
