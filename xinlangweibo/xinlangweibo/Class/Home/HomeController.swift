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
        //导航条初始化
        setupNav()
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(titleBtnClick), name: NSNotification.Name(rawValue: LYPresentationManagerDidPresented), object: animateManager);
        NotificationCenter.default.addObserver(self, selector: #selector(titleBtnClick), name: NSNotification.Name(rawValue: LYPresentationManagerDidDismiss), object: animateManager);
    }
    
    @objc private func titleBtnClick()
    {
        titBtn.isSelected = !titBtn.isSelected;
    }
    //清理通知
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc
    
    private func setupNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftBarItemClick(button:)));
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightBarItemClick(button:)))
        
        navigationItem.titleView = titBtn
    }
    
//点击titleview
    @objc private func titBtnClicked(button: UIButton){
        
        
        let popOverSB = UIStoryboard(name: "Popover", bundle: nil)
        //不确定是不是有值 ，守护如果没有 条件成立，
        guard let menuView = popOverSB.instantiateInitialViewController() else {
            return
        }
        //自定义转场动画
        /*
         1  设置转场代理
         
         2  设置转场样式
         
         */
        menuView.transitioningDelegate = animateManager;
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        
        //弹出菜单
        present(menuView, animated: true, completion: nil)
    }
    

    @objc  private    func leftBarItemClick(button:UIButton)->()
    {
        
    }
    
    @objc  private func rightBarItemClick(button: UIButton)->()
    {
        //创建二维码控制器
        
        let sb = UIStoryboard(name: "QRCode", bundle: Bundle.main);
        
        let vc = sb.instantiateInitialViewController()!

        present(vc, animated: true, completion: nil);
        
        //弹出二维码控制器
    }
    //MARK: - 懒加载
    private lazy var animateManager:LYPresentationManager  =
    {
        let animate = LYPresentationManager()
        animate.presentViewFrame = CGRect(x: 100, y: 54, width: 150, height: 400)
        return animate
    }()
//标题按钮
    private lazy var titBtn: TitleButton = {
        let titleBtn = TitleButton();
        let title = UserAccount.loadUserAccount()?.screen_name;
        titleBtn.setTitle(title, for: UIControlState.normal)
        titleBtn.addTarget(self, action: #selector(titBtnClicked(button:)), for: UIControlEvents.touchUpInside)
        return titleBtn

    }()
    
}



