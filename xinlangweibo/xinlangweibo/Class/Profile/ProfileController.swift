//
//  ProfileController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/26.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class ProfileController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin
        {
            //设置访客视图
            visitView.setupVisitInfo(imageName: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
        
    }

}
