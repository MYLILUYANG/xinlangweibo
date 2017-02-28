//
//  AppDelegate.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/25.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.rootViewController = MainTabBarController();
        window?.backgroundColor = UIColor.white;
        window?.makeKeyAndVisible();
        
        UINavigationBar.appearance().tintColor = UIColor.orange;
        
        return true
    }

}

// 打印日志 需要自定义宏

func LYLog<T>(logName: T,funcName: String = #function, funcFile: String = #file, funcLine:Int = #line ){
    
    #if DEBUG
    print("\(funcName)-\(funcLine)-\(logName)");
    #endif
}
