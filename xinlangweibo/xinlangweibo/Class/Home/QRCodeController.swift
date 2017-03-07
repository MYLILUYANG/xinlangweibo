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
    ///自定义扫描控区域
    @IBOutlet weak var customContatineView: UIView!
    
    @IBOutlet weak var resuleLabel: UILabel!
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
        
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds;
        
        //添加容器layer
        view.layer.addSublayer(contationLayer);
        contationLayer.frame = view.bounds;
        
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
  //选择相册
    @IBAction func photoNavItem(_ sender: Any) {
 
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            LYLog(logName: "不能打开相册");
            return
        }
        present(imagePickController, animated: true, completion: nil);
        
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
    private lazy var output:AVCaptureMetadataOutput = {
       
        let out = AVCaptureMetadataOutput();
        //设置输出对象解析数据时感兴趣的范围，只有在这个范围内才会去解析 默认0、0、1、1 传入的是想对屏幕宽度比例
        //注意： 在计算范围时时根据横屏额左上角为原点，不是竖屏
        
        //获取屏幕frame
        let frame = self.view.frame;
        
        let containeRect = self.customContatineView.frame;
 
        let x = containeRect.origin.y / frame.height;
        
        let y =  containeRect.origin.x / frame.width;
        
        let width = containeRect.height / frame.height;
        
        let height = containeRect.width / frame.width;
        
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        return out;
    }();

    lazy var previewLayer:AVCaptureVideoPreviewLayer = {
        
        return AVCaptureVideoPreviewLayer(session: self.session);
    }()
    
    lazy var contationLayer = CALayer()
    
    lazy var imagePickController:UIImagePickerController = {
        let imagePick = UIImagePickerController();
        imagePick.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePick.delegate = self;
        return imagePick;
    }()
    
}

extension QRCodeController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        // 扫描到结果就会调用
        //显示结果
        clearLayers()
        resuleLabel.text = (metadataObjects.last as AnyObject).stringValue
        //2 、对扫描到的二维码描边
        guard let metaData = metadataObjects.last as? AVMetadataObject   else {
            return
        }
        let objc = previewLayer.transformedMetadataObject(for: metaData)
//        LYLog(logName: (objc as? AVMetadataMachineReadableCodeObject)?.corners);
        drawLines(objc: (objc as? AVMetadataMachineReadableCodeObject)!)

    }
    
    private func drawLines(objc: AVMetadataMachineReadableCodeObject)
    {
        //安全校验
        
        guard let array = objc.corners else {
            return;
        }
        
        //1、创建图片，用于保存绘制的矩形
        
        let drawLayer = CAShapeLayer()
        drawLayer.lineWidth = 2;
        drawLayer.strokeColor = UIColor.green.cgColor;
        drawLayer.fillColor = UIColor.clear.cgColor
        //2、 创建UIbezierPath 绘制矩形
        
        var point = CGPoint.zero;
        var index = 0;
        let path = UIBezierPath();
        path.move(to: CGPoint.init(dictionaryRepresentation: (array[index]) as! CFDictionary)!)
        
        while index < array.count {
            point = CGPoint.init(dictionaryRepresentation: (array[index]) as! CFDictionary)!
            index += 1
            path.addLine(to: point)
            
        }
        path.close()
        drawLayer.path = path.cgPath;
        //3 、将用于保存矩形的图层添加到界面上
        contationLayer.addSublayer(drawLayer)
    }
    
    private func clearLayers()
    {
        guard let subLayers = contationLayer.sublayers else {
            return;
        }
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
}

extension QRCodeController:UITabBarDelegate{
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.contentViewHCons.constant = item.tag == 1 ? 150 : 230;
        
        view.layoutIfNeeded()
        //移除动画
        scanLineImageView.layer.removeAllAnimations()
        //重新开始动画
        startAnimate();
        
    }
    
}

extension QRCodeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
       
        //1、取出选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            LYLog(logName: "获取图片失败")
            return
        }
        guard let detectorCiImage = CIImage(image: image) else {
            LYLog(logName: "转换ciimage失败")
            return
        }
        //2、从选中的图片中读取二维码
        //2.1 创建一个探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        //2.2 利用探测器探测数据
        let results = detector?.features(in: detectorCiImage, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        //2.3 取出探测二期的数据
        for result in results! {
            LYLog(logName: (result as! CIQRCodeFeature).messageString)
            resuleLabel.text = (result as! CIQRCodeFeature).messageString;
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}
