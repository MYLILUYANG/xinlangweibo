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
        
        
    }
    
    private func setupNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftBarItemClick(button:)));
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightBarItemClick(button:)))
        
        let titleView = TitleButton();
        titleView.setTitle("首页", for: UIControlState.normal)
        titleView.addTarget(self, action: #selector(titBtnClicked(button:)), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleView
    }
    
//点击titleview
    @objc private func titBtnClicked(button: UIButton){
        
        button.isSelected = !button.isSelected
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
        
        menuView.transitioningDelegate = self;
        menuView.modalPresentationStyle = UIModalPresentationStyle.custom
        
        //弹出菜单
        present(menuView, animated: true, completion: nil)
    }
    

    @objc  private    func leftBarItemClick(button:UIButton)->()
    {
        
    }
    
    @objc  private func rightBarItemClick(button: UIButton)->()
    {
        
    }
}

extension HomeController:UIViewControllerTransitioningDelegate
{
    //该方法用户返回一个负责转场动画的对象
   public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return LYPresentationController(presentedViewController: presented, presenting: presenting)
    }
    //返回一个负责转场动画如何出现的对象
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self;
    }
    //返回一个转场动画如何小时的对象
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self;
    }
    
}

extension HomeController:UIViewControllerAnimatedTransitioning
{
    //告诉系统展现和小时的动画时长
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 12;
    }
    //专门用于管理modal如何展现和消失的，无论展现还是消失都会调用该方法，
    //只要实现这个方法系统就不会有默认动画
    //默认的modal 自下到上移动 就消失了----所有的动画操作都都需要我们自己实现，包括需要展现的视图也需要我们自己添加到容器视图上
    /*
     transitionContext  所有动画需要的东西都保存在上下文中，可以通过transitionContext 获取我们想要的东西
     */
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        //获取需要弹出的视图
        

        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return;
        }
        
//        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        // 将需要弹出的视图添加到contentview 上
        transitionContext.containerView.addSubview(toView)
        
        //执行动画
        
        
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: 2, animations: { 
             toView.transform = .identity
        }) { (_) in
            //自定义转场，在执行动画完毕后一定要告诉系统动画执行完毕
            transitionContext.completeTransition(true)
        }
        
    }
}
