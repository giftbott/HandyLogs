//
//  AppDelegate.swift
//  HandyLogs
//
//  Created by giftbot on 2017. 4. 30..
//  Copyright © 2017년 giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        let viewController = ViewController()
        window.rootViewController = viewController
        self.window = window
        
        return true
    }
}

