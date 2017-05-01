//
//  ViewController.swift
//  HandyLogs
//
//  Created by giftbot on 2017. 4. 30..
//  Copyright © 2017년 giftbot. All rights reserved.
//

import UIKit
import HandyLogs

class ViewController: UIViewController {
    
    let name   = "HandyLogs"
    let author = "giftbot"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Handy.log("Default log type is info type")
        Handy.log("You can change log type easily", logType: .warning)
        Handy.log("Variadic parameters are available\n",
                  type(of: self), "'s frame :", self.view.frame, ":D", logType: .debug)
        
        Handy.defaultLogType = .debug
        Handy.LogType.debugEmoji = "🔰"
        Handy.LogType.infoEmoji = "🔥"
        Handy.log("DefaultLogType & emoji are changable")
        
        Handy.log("If you set enableLogging as false", logType: .fatal)
        Handy.enableLogging = false
        
        Handy.cLog("All logs are never printed")
        Handy.dLog()
        Handy.wLog("And use these c,d,w,e,f Logs to change logType easily")
        Handy.eLog()
        
        Handy.enableLogging = true
        Handy.fLog("Using description function, it will prints all properties of class you want")
        Handy.description(self)
    }
}
