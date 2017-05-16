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

public struct HandyLogTypeOption {
  private init() {}
  
  public static var `default`: LogType = .info
  
  public enum LogType {
    case info, check, debug, warning, error, fatal
    
    var name: String {
      switch self {
      case .info:     return "Info "
      case .check:    return "Check"
      case .debug:    return "Debug"
      case .warning:  return "Warn "
      case .error:    return "Error"
      case .fatal:    return "Fatal"
      }
    }
    
    var image: String {
      switch self {
      case .info:     return HandyLogTypeOption.infoEmoji
      case .check:    return HandyLogTypeOption.checkEmoji
      case .debug:    return HandyLogTypeOption.debugEmoji
      case .warning:  return HandyLogTypeOption.warningEmoji
      case .error:    return HandyLogTypeOption.errorEmoji
      case .fatal:    return HandyLogTypeOption.fatalEmoji
      }
    }
  }
  
  /// Alterable emojis
  ///
  ///     HandyLogTypeOption.infoEmoji = "✳️"
  public static var infoEmoji: String = "✳️"
  public static var checkEmoji: String = "☑️"
  public static var debugEmoji: String = "🔥"
  public static var warningEmoji: String = "⚠️"
  public static var errorEmoji: String = "❌"
  public static var fatalEmoji: String = "🆘"
}


public struct HandyLogPrintOption {
  private init() {}
  
  /// When enableLogging is false, Log don't be printed
  public static var enableLogging = true
  
  /// if true, print contents under base log message
  public static var isPrintAtNewLine = false
  
  /// Alterable emojis
  ///
  ///     HandyLogPrintOption.timestampEmoji = "⏱"
  public static var timestampEmoji = "⏱"
  public static var executedLineEmoji = "➡️"
  
  public static var mainThreadEmoji: String?
  public static var backgroundThreadEmoji: String?
  
  public static var divisionLineEmoji = "="
  public static var repeatDivisionLineCharacter = 80
  
}

