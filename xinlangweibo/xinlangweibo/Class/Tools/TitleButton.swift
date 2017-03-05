//
//  TitleButton.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/1.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
/*
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        
    }
 */
    
    //  ？？ 用于判断前面参数是不是nil  如果是nil就返回 ？？ 前面的数据，如果不是nil 那么就不执行？？ 后的语句
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle((title ?? "") + " ", for: state)
    }
    
    override func layoutSubviews() {
        //设置控件的偏移位
    super.layoutSubviews()
        
        //和OC不太一样 ，swift 允许直接修改一个结构体的对象属性的成员
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.width)!;
        
    }

    //纯代码时创建
    //在swift 中如果想要重写父类的方法，必须要前面添加voerride
   override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named:"navigationbar_arrow_up"), for: UIControlState.normal)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: UIControlState.selected)
        setTitleColor(UIColor.black, for: UIControlState.normal)
        sizeToFit()

    }
    //通过xib  / sb 创建时调用
    required init?(coder aDecoder: NSCoder) {
        //系统对initWithCoder  的默认实现是报一个致命错误。
        fatalError("init(coder:) has not been implemented")
    }
    
}
