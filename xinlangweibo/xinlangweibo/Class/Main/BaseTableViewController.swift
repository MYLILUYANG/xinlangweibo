//
//  BaseTableViewController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/2/28.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var isLogin = true;
    //需要 定义的时候初始化
    var visitView = VisitorVIew()
    
    override func loadView() {
        super.loadView()

        //判断用户是否有登录，如果没有登录就显示访客界面，已登录就显示tableview
        
        isLogin ? super.loadView() : setupView()

    }
    // MARK - 内部控制方法
    private func setupView(){
        
        //创建访客视图
        visitView = VisitorVIew.visitView()

        visitView.registBtn.addTarget(self, action:#selector(BaseTableViewController.regisBtnClick), for: UIControlEvents.touchUpInside)
        
        visitView.loginBtn.addTarget(self, action:#selector(BaseTableViewController.loginBtnClick), for: UIControlEvents.touchUpInside);
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableViewController.regisBtnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseTableViewController.loginBtnClick))
      
        view = visitView;
        // 设置代理
//        visitView.delegate = self as?VisitorViewDelegate
        
    }
    
    @objc private func regisBtnClick() ->Void{
        
    }
    
    @objc  private func loginBtnClick() ->Void{
        
    }
}
//extension BaseTableViewController: VisitorViewDelegate
//{
//    func visitorViewDidClickLoginBtn(view: VisitorVIew) {
//        LYLog(logName: "login")
//    }
//
//    func visitorViewDidClickRegisBtn(view: VisitorVIew) {
//        LYLog(logName: "regis")
//    }
//}

