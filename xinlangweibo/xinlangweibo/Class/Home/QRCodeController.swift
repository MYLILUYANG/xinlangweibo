//
//  QRCodeController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/5.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeController: UIViewController {
//底部工具条
    @IBOutlet weak var customTabbar: UITabBar!
    //冲击波顶部约束
    @IBOutlet weak var scanLIneCons: NSLayoutConstraint!
    //容器视图的高度约束
    @IBOutlet weak var contentViewHCons: NSLayoutConstraint!
    //显示冲击波的图片视图
    @IBOutlet weak var scanLineImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabbar.selectedItem = customTabbar.items?.first
        //设置添加监听，监听底部工具条监听
        customTabbar.delegate = self;
        //  开始扫描二维码
        scanQRCode()
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        startAnimate();
    }
    
    private func scanQRCode()
    {
        //1 判断输入能否添加到回话中
        
        if !session.canAddInput(input)
        {
            return;
        }
        
        //2、判断输出
        if !session.canAddOutput(output)
        {
            return;
        }
        // 3、添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        // 4、 设置输出能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes;
        // 5、 设置监听输出输出解析到的数据
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//6 、添加预览图层
        
        view.layer .insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds;
        
        // 7、 开始扫描
        session.startRunning()
    }
    
    func startAnimate()
    {
        
        //设置冲击波约束
        //1 设置冲击波底部和
        scanLIneCons.constant = -contentViewHCons.constant;
        view.layoutIfNeeded()
        //执行扫描动画
        UIView.animate(withDuration: 2, animations: {
            //在swift 中不用写 self 也不推荐写self 一般情况下只有需要区分两个变量，或者在闭包中访问外部属性才需要加self
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLIneCons.constant = self.contentViewHCons.constant
            self.view.layoutIfNeeded()
        })
        
    }
  
    @IBAction func photoNavItem(_ sender: Any) {
 
    }
    @IBAction func coloseNavItem(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    //MARK: - 懒加载
    //输入对象
    private lazy var input: AVCaptureDeviceInput? = {
       
       let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);

        return try? AVCaptureDeviceInput(device: device);
    }()
    //会话
    private lazy var session:AVCaptureSession =  AVCaptureSession();
    //输出对象
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput();

    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
        
        return AVCaptureVideoPreviewLayer(session: self.session);
    }()
    
}

extension QRCodeController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        // 扫描到结果就会调用
        LYLog(logName: (metadataObjects.last as AnyObject).stringValue)
    }
}

extension QRCodeController:UITabBarDelegate{
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.contentViewHCons.constant = item.tag == 1 ? 150 : 300;
        
        view.layoutIfNeeded()
        //移除动画
        scanLineImageView.layer.removeAllAnimations()
        //重新开始动画
        startAnimate();
        
    }
    
}
