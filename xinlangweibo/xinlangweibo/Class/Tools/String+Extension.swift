//
//  String+Extension.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/15.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit
extension String
{
    //快速生成缓存路径
    func cachesDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first;
        let name = (self as NSString).lastPathComponent
        let filePath = path?.appending(name);
        
        return filePath!

    }
    //快速文档路径
    func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        
        let name = (self as NSString).lastPathComponent
        let filePath = path?.appending(name);
        
        return filePath!
    }
    //快速生成临时路径
    func tmpDir() -> String {
        let path = NSTemporaryDirectory();
        
        let name = (self as NSString).lastPathComponent
        let filePath = path.appending(name);
        
        return filePath
    }
    
}

