//
//  LYPresentationManager.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/5.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class LYPresentationManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    //定义标记 记录当前是否是展现或者消失
    var isPrsent = false;
    var presentViewFrame:CGRect = CGRect.zero;
    
    //MARK: - UIViewControllerTransitioningDelegate
    //该方法用户返回一个负责转场动画的对象
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let presentViewController = LYPresentationController(presentedViewController: presented, presenting: presenting)
        presentViewController.presentViewFrame = presentViewFrame;
        return presentViewController
    }
    //返回一个负责转场动画如何出现的对象
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LYPresentationManagerDidPresented), object: self)
        isPrsent = true;
        return self;
    }
    //返回一个转场动画如何消失的对象
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        
        NotificationCenter.default.post(name: NSNotification.Name(LYPresentationManagerDidDismiss), object: self)
        isPrsent = false;
        return self;
    }
    
    //MARK: - UIPresentationController
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
        if isPrsent
        {
            willPresentedController(using: transitionContext)
        }else
        {
            willDismissdController(using: transitionContext);
        }
    }
//执行展现动画
    private func willPresentedController(using transitionContext: UIViewControllerContextTransitioning){
        //获取需要弹出的视图
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return;
        }
        // 将需要弹出的视图添加到contentview 上
        transitionContext.containerView.addSubview(toView)
        //执行动画
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            toView.transform = .identity
        }) { (_) in
            //自定义转场，在执行动画完毕后一定要告诉系统动画执行完毕
            transitionContext.completeTransition(true)
        }
    }
    //执行消失动画
    private func willDismissdController(using transitionContext: UIViewControllerContextTransitioning){
        //获取应该消失的view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from);
        
        //执行消失的动画
        UIView.animate(withDuration: 0.5, animations: {
            fromView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0000000001)
        }, completion: { (true) in
            transitionContext.completeTransition(true)
        })
    }
}
