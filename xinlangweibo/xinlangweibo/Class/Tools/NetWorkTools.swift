//
//  NetWorkTools.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/11.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
import AFNetworking
class NetWorkTools: AFHTTPSessionManager {

    //swift 推荐这样写单例
    static let shareInstance:NetWorkTools = {
      //  https://api.weibo.com/
        let baseURL = NSURL(fileURLWithPath: "https://api.weibo.com/")
        let instance = NetWorkTools()
//        let instance = NetWorkTools(baseURL: baseURL as URL, sessionConfiguration: URLSessionConfiguration.default);
        
        instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set
        
        instance.securityPolicy.allowInvalidCertificates = false;
        
        instance.securityPolicy.validatesDomainName = true;

        instance.responseSerializer = AFHTTPResponseSerializer()

        return instance;
        
    }()
    
   
}
