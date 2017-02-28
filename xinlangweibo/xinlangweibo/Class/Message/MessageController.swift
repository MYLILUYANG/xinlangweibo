//
//  MessageController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/26.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class MessageController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin
        {
            //设置访客视图
            visitView.setupVisitInfo(imageName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
            return
        }
    }

 
}
