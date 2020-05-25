//
//  AppDelegate.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/05/18.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

extension UIApplication {
    var statusView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBar = UIView(frame: keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect(x: 0, y: 0, width: 0, height: 0))
                statusBar.tag = tag
                keyWindow?.addSubview(statusBar)
                return statusBar
            }
        } else {
            return UIApplication.shared.value(forKey: "statusBar") as? UIView
        }
    }
}

