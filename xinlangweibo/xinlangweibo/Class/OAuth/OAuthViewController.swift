//
//  OAuthViewController.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/9.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
import AFNetworking
import MJExtension
class OAuthViewController: UIViewController {
    //  网页容器
//    App Key：742201608

//    App Secret：22c579eba6c42371b69619bd7677e090
    //    https://api.weibo.com/oauth2/authorize?client_id=742201608&redirect_uri=https://www.baidu.com
//      重定向code requestToken
    @IBOutlet weak var customWebVIew: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=742201608&redirect_uri=https://www.baidu.com"
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
       let request = URLRequest(url: url)
        customWebVIew.loadRequest(request);
        customWebVIew.delegate = self;
    }
  }
extension OAuthViewController:UIWebViewDelegate {
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        
        guard let geturlStr = request.url?.absoluteString else {
            return false;
        }
        
        if !geturlStr.hasPrefix("https://www.baidu.com") {
            LYLog(logName: "不是授权回调页面")
            return true;
        }
        LYLog(logName: "是授权回调页面")
        
        let key = "code="
        
        if geturlStr.contains(key) {
            LYLog(logName: "授权成功");
           let code = request.url!.query?.substring(from: key.endIndex);
            
            loadAccessToken(code:code)
            return false;
        }
        LYLog(logName: "授权失败");
        return false;
    }
    
    private func loadAccessToken(code:String?){
        
        guard let codeStr = code else {
            return;
        }
        
        //准备请求lujing
        // https://api.weibo.com/oauth2/access_token
        
        let path:String = "oauth2/access_token"

        
        //准备请求参数

        
        let parames = [
                "client_id":"742201608",
            "client_secret":"22c579eba6c42371b69619bd7677e090",
               "grant_type":"authorization_code",
                     "code":codeStr,
             "redirect_uri":"https://www.baidu.com"
        ]
        //发送post 请求
        let manager = AFHTTPSessionManager();
        manager.responseSerializer = AFHTTPResponseSerializer();
        manager.securityPolicy.validatesDomainName = false;
        manager.securityPolicy.allowInvalidCertificates = false;
        manager.post("https://api.weibo.com/oauth2/access_token", parameters: parames, progress: { (progress) in
            
        }, success: { (task, objc) in
            
            let name = (objc as AnyObject).mj_JSONObject()
            
            LYLog(logName: name );
            
        }) { (task, error) in
            
          LYLog(logName: error);
            
        }
        
        
//        NetWorkTools.shareInstance.post("https://api.weibo.com/oauth2/access_token", parameters: parames, progress: { (progress) in
//            LYLog(logName: progress);
//        }, success: { (URLSessionDataTask, objc) in
//             LYLog(logName: objc);
//        }) { (task:URLSessionDataTask?, error) in
//            
//            LYLog(logName: error);
//        }
    }
}
