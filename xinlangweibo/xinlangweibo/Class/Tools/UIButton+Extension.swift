//
//  UIButton+Extension.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/27.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

extension UIButton{
    /*
     如果构造方法前面没有  convenience  ，代表这是一个初始化构造方法，（指定构造方法）
     如果有 代表这是一个遍历构造方法
     
     指定构造方法必须对所有的属性进行初始化
     遍历构造方法中不用对所有的属性进行初始，因为遍历构造依赖于指定构造
     一般情况下如果想给系统的类提供一个快速创建方法，就自定义一个遍历构造方法。
     */
    convenience init(image: String?, backgroundImage:String?) {
        self.init();
        
        
        
        if let name = image {
            
            setImage(UIImage(named:name), for: .normal);
            setImage(UIImage(named: name + "_highligted"), for: .highlighted);
        }
        
        if let hightName = backgroundImage {
            setBackgroundImage(UIImage(named:hightName), for: .normal)
            setBackgroundImage(UIImage(named: hightName + "_highligted"), for: .highlighted);
            
        }

        sizeToFit()
    }
    
}
