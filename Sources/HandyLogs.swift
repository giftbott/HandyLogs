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
        
        public static var infoImage: String = "✳️"
        public static var checkImage: String = "☑️"
        public static var debugImage: String = "🔥"
        public static var warningImage: String = "⚠️"
        public static var errorImage: String = "❌"
        public static var fatalImage: String = "🆘"
        
        fileprivate var image: String {
            switch self {
            case .info:     return LogType.infoImage
            case .check:    return LogType.checkImage
            case .debug:    return LogType.debugImage
            case .warning:  return LogType.warningImage
            case .error:    return LogType.errorImage
            case .fatal:    return LogType.fatalImage
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
}
