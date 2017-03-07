//
//  QRCodeMyCardViewControl.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/7.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class QRCodeMyCardViewControl: UIViewController {
    //二维码容器
    @IBOutlet weak var customImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

     //生成二维码属于滤镜的一种
        //1、创建滤镜
        let filiter  = CIFilter(name: "CIQRCodeGenerator");
        //还原默认设置
        filiter?.setDefaults()
        //设置生成二维码需要的数据到滤镜中
        filiter?.setValue("你好！王宝芹，宝宝爱你呦！！！".data(using: String.Encoding.utf8), forKey: "InputMessage")
        
        //从滤镜中取出生成好的二维码图片
        guard let ciimage = filiter?.outputImage else {
            return
        }
        self.customImageView.image = creatNonInterpolatedUIImageFormCIImage(image: ciimage, size: 300)
            
//            UIImage(ciImage: ciimage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     生成高清二维码
     */
    
    private func creatNonInterpolatedUIImageFormCIImage(image:CIImage, size:CGFloat) -> UIImage{
        
        let extent: CGRect = image.extent.integral;
        
        let scale: CGFloat = min(size/extent.width, size/extent.height);
        //创建bitmap
        let width = extent.width * scale;
        let height = extent.height * scale;
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitMapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0);
        
        let context = CIContext(options: nil);
        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!;
        
        bitMapRef?.interpolationQuality = CGInterpolationQuality.none;
        bitMapRef?.scaleBy(x: scale, y: scale);
        bitMapRef?.draw(bitmapImage, in: extent)
        //保存bitmap图片
        
        let scaledImage: CGImage = bitMapRef!.makeImage()!
        return UIImage(cgImage: scaledImage);
 
    }
}



















