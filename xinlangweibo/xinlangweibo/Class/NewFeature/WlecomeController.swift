//
//  WlecomeController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/21.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
import SDWebImage
class WlecomeController: UIViewController {
    //头像底部约束
    @IBOutlet weak var icoBbuttonCons: NSLayoutConstraint!
//标题
    @IBOutlet weak var titleLabel: UILabel!
    //头像容器
    @IBOutlet weak var iconImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImageView.layer.cornerRadius = 45.0
        iconImageView.layer.masksToBounds = true;
        assert(UserAccount.loadUserAccount() != nil, "必须授权之后才能显示欢迎界面")
        
        guard let urlStr = UserAccount.loadUserAccount()?.avatar_large else {
            return
        }
        iconImageView.sd_setImage(with: NSURL(fileURLWithPath: urlStr) as URL);
        
    }

    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear(animated)
        
        UIView.animate(withDuration: 3) {
            
            self.icoBbuttonCons.constant = UIScreen.main.bounds.height - self.icoBbuttonCons.constant;
            
        }
        UIView.animate(withDuration: 2, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 2.5, animations: { 
                self.titleLabel.alpha = 1;
            }, completion: { (_ ) in
                LYLog(logName: "s");
            })
        }
        
    }
}
