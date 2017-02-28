//
//  VisitorVIew.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/28.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

/*
protocol VisitorViewDelegate:NSObjectProtocol {

    //默认情况下协议中的方法都必须实现
    func visitorViewDidClickLoginBtn(view:VisitorVIew)
    func visitorViewDidClickRegisBtn(view:VisitorVIew)
    
}
*/
class VisitorVIew: UIView {
//旋转的imageview
    @IBOutlet weak var rotationView: UIImageView!
    //图标
    @IBOutlet weak var iconImageView: UIImageView!
    //文字
    
    @IBOutlet weak var introducLabel: UILabel!
    //注册按钮
    @IBOutlet weak var loginBtn: UIButton!
    //登录按钮
    @IBOutlet weak var registBtn: UIButton!
    //和OC 一样代理需要使用weak 来修饰
//    weak var delegate: VisitorViewDelegate?
    
    //设置访客视图的数据
    //imagename 需要显示的图标
    //title 需要显示的标题
    func setupVisitInfo(imageName: String?, title: String)  {
        //设置标题
        introducLabel.text = title;
        //判断是否是首页
        guard let name = imageName else {
            
            //没有设置图标 首页
            //执行旋转动画
            startAnimate()
            return;
            
        }
        rotationView.isHidden = true;
        //设置其他数据
        iconImageView.image = UIImage(named: name);

    }
    
    class func visitView()->VisitorVIew {
        
        return Bundle.main.loadNibNamed("VisitorVIew", owner: nil, options: nil)?.last as!VisitorVIew
        
    }

    
    private func startAnimate(){
        //动画在willvilldisappar  生命周期会结束，需要设置动画结束时不要移除,
       let animate = CABasicAnimation(keyPath: "transform.rotation")
        
        animate.toValue = 2 * M_PI
        
        animate.duration = 25.0
        
        animate.repeatCount = MAXFLOAT
        
        animate.isRemovedOnCompletion = false;
        
        rotationView.layer.add(animate, forKey: nil)
        
    }
    

    
    
}
