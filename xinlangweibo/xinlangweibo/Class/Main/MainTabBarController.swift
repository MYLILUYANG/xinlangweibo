//
//  MainTabBarController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/26.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orange;
        //添加所有的子控制器
        addChildViewControllers()
/*
        //  1 添加自控制器
        let vc = HomeController();
        vc.tabBarItem.title = "首页"
        vc.tabBarItem.image = #imageLiteral(resourceName: "tabbar_home");
        vc.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabbar_home_highlighted");
        let navigatationcontroller = UINavigationController();
        navigatationcontroller.addChildViewController(vc)
        //ios 7 以后只需要设置titColor 那么图片和文字都会按照titcolor 渲染
        
        tabBar.tintColor = UIColor.orange;
 */

    }
    //override 代表重写父类的方法。
    //swift 支持方法的重载，居士说只要方法的参数个数或者数据类型不同，那么系统就会认为是两个方法。
    //添加一个自控制器
    func addChildViewController(childController: UIViewController, image: UIImage, selectedImage: UIImage, title: String) {
       
        let viewController = childController;
        viewController.title = title;
        
        childController.tabBarItem.image = image;
        childController.tabBarItem.selectedImage = selectedImage;
        
        let navController = UINavigationController();
        navController.addChildViewController(viewController);
        
        
        addChildViewController(navController);
        
    }
//添加所有的子控制器
    func addChildViewControllers (){
        
        addChildViewController(childController: HomeController(), image: #imageLiteral(resourceName: "tabbar_home"), selectedImage: #imageLiteral(resourceName: "tabbar_home_highlighted"), title: "首页");
        addChildViewController(childController: MessageController(), image: #imageLiteral(resourceName: "tabbar_message_center"), selectedImage: #imageLiteral(resourceName: "tabbar_message_center_highlighted"), title: "消息");
        addChildViewController(childController: DiscoverController(), image: #imageLiteral(resourceName: "tabbar_discover"), selectedImage: #imageLiteral(resourceName: "tabbar_discover_highlighted"), title: "发现");
        addChildViewController(childController: ProfileController(), image: #imageLiteral(resourceName: "tabbar_profile"), selectedImage: #imageLiteral(resourceName: "tabbar_profile_highlighted"), title: "我");
  
    }
}
