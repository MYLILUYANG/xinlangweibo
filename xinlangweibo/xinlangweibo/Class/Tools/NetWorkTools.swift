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
//        let instance = NetWorkTools()
        let instance = NetWorkTools(baseURL: baseURL as URL, sessionConfiguration: URLSessionConfiguration.default);
//        let manager = AFHTTPSessionManager(baseURL: baseURL as URL, sessionConfiguration: URLSessionConfiguration.default)
//        let instance = manager

        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javasvript", "text/plain") as? Set
        
        
        instance.securityPolicy.allowInvalidCertificates = false;
        
        instance.securityPolicy.validatesDomainName = true;

//        instance.responseSerializer = AFHTTPResponseSerializer()

        return instance 
        
    }()
    
   
}
