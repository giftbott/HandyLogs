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


//TODO: changeable timestamp formatt, timestamp emoji, funcname emoji
//TODO: choiceable short / full version logging each logtype

public protocol HandyLogProtocol {}
extension NSObject: HandyLogProtocol { }

extension HandyLogProtocol {
  /// Basic log function
  ///
  ///     handyLog(somethingForLogging)
  ///
  /// or input logType you want
  ///
  ///     handyLog(somethingForLogging, type: .error)
  ///
  /// defaultLogType is .info, if type parameter is omitted
  public func handyLog(
    _ objects: Any...,
    type: HandyLogTypeOption.LogType = HandyLogTypeOption.default,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(type, filename, line, funcname, objects)
  }
  
  
  fileprivate func printLog(
    _ logType: HandyLogTypeOption.LogType,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function,
    _ objects: Array<Any>)
  {
    guard HandyLogPrintOption.enableLogging else {
      return
    }
    
    DispatchQueue.global().sync {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm:ss:SSS"
      let timestamp = dateFormatter.string(from: Date())
      let file = URL(string: filename)?.lastPathComponent.components(separatedBy: ".").first ?? "Unknown"
      let queue = Thread.isMainThread ?
        HandyLogPrintOption.mainThreadEmoji ?? "(UI)" :
        HandyLogPrintOption.backgroundThreadEmoji ?? "(BG)"
      
      let logString = ""
        + "\(logType.image)\(logType.name) "
        + "\(HandyLogPrintOption.timestampEmoji)\(timestamp) "
        + "\(queue) "
        + "\(HandyLogPrintOption.executedLineEmoji)\(file).\(funcname)(\(line)) "
        + "\(logType.image)"
      
      
      print(logString, terminator: HandyLogPrintOption.isPrintAtNewLine ? "\n" : " ")
      let _ = objects.map { print($0, terminator: " ") }
      print()
    }
  }
}


//MARK: - Subdevided log
extension HandyLogProtocol {
  
  /// cLog(someObjects...)
  public func cLog(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.check, filename, line, funcname, objects)
  }
  
  /// dLog(someObjects...)
  public func dLog(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.debug, filename, line, funcname, objects)
  }
  
  /// wLog(someObjects...)
  public func wLog(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.warning, filename, line, funcname, objects)
  }
  
  /// eLog(someObjects...)
  public func eLog(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.error, filename, line, funcname, objects)
  }
  
  /// fLog(someObjects...)
  public func fLog(
    _ objects: Any...,
    _ filename: String = #file,
    _ line: Int = #line,
    _ funcname: String = #function)
  {
    printLog(.fatal, filename, line, funcname, objects)
  }
}



//MARK: The other handy log functions
extension HandyLogProtocol {
  /// Print division line
  func handyLogDivisionLine() {
    guard HandyLogPrintOption.enableLogging else {
      return
    }
    
    let divisionLineString = String(repeating: HandyLogPrintOption.divisionLineEmoji,
                                    count: HandyLogPrintOption.repeatDivisionLineCharacter)
    print("\n" + divisionLineString + "\n")
  }
  
  /// Print all properties of object
  ///
  ///     handyDescription(someClassInstance)
  ///     handyDescription(someStruct)
  public func handyDescription(_ object: Any) {
    guard HandyLogPrintOption.enableLogging else {
      return
    }
    
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
