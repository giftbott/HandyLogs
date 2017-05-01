// MIT License
//
// Copyright (c) 2017 Giftbot (giftbott@gmail.com)
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

//TODO: Add different description type

public protocol HandyDescription: CustomStringConvertible, CustomDebugStringConvertible {
    /// For class where already conforming CustomStringConvertible protocol
    ///
    ///     let view = UIView()
    ///     print(view.desc)
    var desc: String { get }
    
    
    /// For CustomStringConvertible implementation
    ///
    ///     let customClass = CustomClass()
    ///     print(customClass)
    var description: String { get }
    
    /// For CustomDebugStringConvertible implementation
    var debugDescription: String { get }
}

extension HandyDescription {
    public var desc: String {
        return handyDescription()
    }
    
    public var description: String {
        return handyDescription()
    }
    
    public var debugDescription: String {
        return handyDescription()
    }
    
    /// print all properties of self & super class
    private func handyDescription() -> String {
        var description = "\n✨ \(type(of: self)) "
        description += "<\(Unmanaged.passUnretained(self as AnyObject).toOpaque())> ✨\n"
        
        let selfMirror = Mirror(reflecting: self)
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
        
        return description
    }
}
