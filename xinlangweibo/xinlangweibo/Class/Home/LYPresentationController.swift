//
//  LYPresentationController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/2.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class LYPresentationController: UIPresentationController {
     
    /*
     1、 如果不自定义转场modal 出来的控制器会移除原来的控制器
     2、 如果自定义转场modal 出来的控制器不会移除原来的控制器
     3、 如果不自定义转场modal 出来的控制器的尺寸和屏幕一样，
     如果自定义转成model 出来的控制器我们可以在 containerViewWillLayoutSubviews() 方法中控制contentview 非常重要，容器视图，所有modal 出来的视图都添加在contentview 上
     presentedView 能够拿到弹出的视图
     */
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    
    //用于布局转场动画弹出的控件
   override func containerViewWillLayoutSubviews() {
    
    // containerView 非常重要
//    presentedView  非常重要 ，能够通过该方法拿到弹出的视图
    presentedView?.frame = CGRect(x: 100, y: 55, width: 200, height: 200)
    LYLog(logName: containerView);
    }
    // MARK: - 懒加载
    
    
}
