//
//  HomeController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/26.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class HomeController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin
        {
           //设置访客视图
            visitView.setupVisitInfo(imageName: nil, title: "关注的一些人，回这里看看有什么惊喜")
            return
        }
        
    }

 }
