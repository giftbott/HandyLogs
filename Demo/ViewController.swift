//
//  ViewController.swift
//  HandyLogs
//
//  Created by giftbot on 2017. 4. 30..
//  Copyright © 2017년 giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
                
        Handy.log("If you set custom flag: SUBDIVIDE", logType: .fatal)
        
        #if SUBDIVIDE
            Handy.cLog("Subdivided functions will be provided")
            Handy.dLog("to more convenience use for each log type")
            Handy.wLog()
            Handy.eLog()
            Handy.fLog()
        #endif
        
    }
}
