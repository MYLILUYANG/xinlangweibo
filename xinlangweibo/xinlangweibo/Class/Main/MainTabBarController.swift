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
        //动态添加或者修改tabbar 的显示需要将controller 提前写好，才可以根据json 进行切换
        addChildViewControllers()

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.addSubview(composeButton);
//        composeButton.center = tabBar.center
//        composeButton.center = CGPoint(x: tabBar.center.x, y: 0);
        
        let rect = composeButton.frame;
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count);
        //设置按钮位置
        composeButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: rect.height);
        
        
    }
    
    //override 代表重写父类的方法。
    //swift 支持方法的重载，居士说只要方法的参数个数或者数据类型不同，那么系统就会认为是两个方法。
    //添加一个自控制器
    private  func addChildViewController(childController: String?, image: String?, title: String?) {
 
        //swift 新增一个叫命名空间的概念，
//        作用 ;避免重复
//        不同项目中的命名空间按是不一样的，默认情况下命名空间的名称就是当前项目的名称
//        正是因为swift 可以通过命名空间来解决重命名的问题，所以在swift 开发室尽量使用cocoapods 来集成第三方框架，这样可以有效的避免重复命名，z
        //正是因为swift 中有命名空间所以通过一个字符串来创建一个类，OC中可以直接通过类名创建，儿swift 中如果想要通过类名创建一个类，必须加上命名空间

        
        // 1.动态获取命名空间
        guard let name =  Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else
        {
            return
        }
        
        // 2.根据字符串获取Class
        var cls: AnyClass? = nil
        if let vcName = childController
        {
            cls = NSClassFromString(name + "." + vcName)
            
        }
        
        // 3.根据Class创建对象
        // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
        guard let typeCls = cls as? UITableViewController.Type else
        {
            LYLog(logName: "不能创建类")
            return
        }
        // 通过Class创建对象
        let childController = typeCls.init()
        
        
        // 1.2设置自控制的相关属性
        childController.title = title
        if let ivName = image
        {
            childController.tabBarItem.image = UIImage(named: ivName)
            childController.tabBarItem.selectedImage = UIImage(named: ivName + "_highlighted")
        }
        
        // 1.3包装一个导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 1.4将子控制器添加到UITabBarController中
        addChildViewController(nav)
        
        
    }
//添加所有的子控制器
    
    private  func addChildViewControllers (){
        
        // 根据json 文件创建控制器。
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            LYLog(logName: "获取文件路径失败");
            return;
        }
      ;
        LYLog(logName: filePath);
        
        guard let data = NSData (contentsOfFile: filePath) as?Data else {
            LYLog(logName: "加载二进制数据失败");
            return
        }
        
//        guard JSONSerialization.isValidJSONObject(data) else {
//            LYLog(logName: "json转换失败")
//            return
//        }
        
        do {
            //
            //oc中如果发生错误会给传入的指针赋值。
            //swift 中使用的是异常处理机制，以后但凡有throw 的方法，必须进行try catch 处理
            // 只要看到try 就需要些do catch  只要do 中的代码发生了错误，才会执行catch{}中的代码
            /*
             try   正常处理异常 通过do{}catch{} 处理
             try!  告诉系统一定不会有异常就是说可以不通过docatch处理，但是注意开发中不推荐使用，一旦发生异常就会crush 如果没有异常会直接返回一个
             try?   告诉系统可能会有错误，也可能没有错误，如果无错误系统会自动将结果处理成一个可选类型给我们，如果有错误系统会返回nil ，如果使用try？处理那么可以不使用docatch 处理
             */
          let objc = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as![[String:AnyObject]];
            //[[String:AnyObject]]  代表数组字典
            LYLog(logName: objc);
            //遍历数组字典，取出每一个字典
            for dict in objc
            {
                
                let title = dict["title"] as? String;
                let vcName = dict["vcName"] as?String;
                let imageName = dict["imageName"] as?String;
                
                addChildViewController(childController: vcName, image: imageName, title: title)

            }
            
        } catch  {


            addChildViewController(childController: "HomeController", image: "tabbar_home", title: "首页")
            addChildViewController(childController: "HomeController", image: "tabbar_message_center", title: "消息")
            addChildViewController(childController: "HomeController", image: nil, title: nil)
            addChildViewController(childController: "HomeController", image: "tabbar_discover", title: "发现")
            addChildViewController(childController: "HomeController", image: "tabbar_profile", title: "我")
            
        }

    }
    
    /*
     public   :最大权限，在当前frame和其他frame中访问
     internal :默认权限，在当前frame中随意访问
     private  :私有权限，只能在文件中访问
     以上权限可以修饰方法，属性.在企业开发中严格控制权限，不想让别人访问的东西一定要private
     */
    //
    @objc private  func composeBtnClick(){
        LYLog(logName: 1212);
    }
    // MARK -懒加载
    private  lazy var composeButton: UIButton = {
        () ->UIButton
        in
        let btn = UIButton()
        //前景色
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: UIControlState.highlighted)
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: UIControlState.normal)
        //背景色
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: UIControlState.normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        //调整大小
        
        btn.sizeToFit()
        //监听按钮点击
        btn.addTarget(self, action: #selector(MainTabBarController.composeBtnClick), for: UIControlEvents.touchUpInside)
        return btn;
        
        
    }()
    
    
}
