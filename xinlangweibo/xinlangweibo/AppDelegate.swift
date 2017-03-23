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
        UITabBar.appearance().tintColor = UIColor.orange;
//        
        LYLog(logName: UserAccount.loadUserAccount())
//        
//        
        LYLog(logName: "/sdsds".cachesDir()) 
        
//        LYLog(logName: isNewVersion())
        
        return true
    }

}

// 打印日志 需要自定义宏

func LYLog<T>(logName: T,funcName: String = #function, funcFile: String = #file, funcLine:Int = #line ){
    
    #if DEBUG
    print("\(funcName)-\(funcLine)-\(logName)");
    #endif
}

extension AppDelegate
{
    private func isNewVersion()->Bool
    {
        //加载info.plist
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as!String
//        let sanboxVersion = "1.0";
        //获取以前的软件版本号
        let defaulte = UserDefaults.standard
        let sanboxVersion = (defaulte.object(forKey: "version") as? String) ?? "0.0"

        if currentVersion.compare(sanboxVersion) == ComparisonResult.orderedDescending {
            
            LYLog(logName: "you xin banben ")
            //如果有新版本，就利用新版本的版本号更新本地的版本
            defaulte.set(currentVersion, forKey: "version")
            defaulte.synchronize()//ios  7 之前需要写。之后不需要
            return true;
        }
        LYLog(logName: "meiyou  xin banben ")
        return false;

    }
}
