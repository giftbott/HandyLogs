//
//  ViewController.swift
//  HandyLogs
//
//  Created by giftbot on 2017. 4. 30..
//  Copyright © 2017년 giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let name   = "HandyLogs"
  let author = "giftbot"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    handyLog("Default log type is info type")
    handyLog("You can change log type easily", type: .warning)
    handyLog("Variadic parameters are available\n",
              type(of: self), "'s frame :", self.view.frame, ":D", type: .debug)
    
    HandyLogTypeOption.default = .debug
    HandyLogTypeOption.debugEmoji = "🔰"
    HandyLogTypeOption.infoEmoji = "🔥"
    handyLog("DefaultLogType & emoji are alterable")
    
    handyLog("If you set enableLogging as false", type: .fatal)
    HandyLogPrintOption.enableLogging = false
    
    handyLog("All logs are never printed")
    dLog()
    wLog("And use these c,d,w,e,f Logs to change logType easily")
    eLog()
    
    handyLogDivisionLine()
    
    HandyLogPrintOption.enableLogging = true
    cLog("Using description function, it will prints all properties of class you want")
    handyDescription(self)
  }
}
