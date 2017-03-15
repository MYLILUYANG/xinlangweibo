//
//  UserAccount.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/14.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    
    var access_token:String?
    
    var expires_in:Int = 0
    
    var uid: String?
    
    init(dict:[String: AnyObject])
    {
        super.init()
        self.setValuesForKeys(dict)
//        self.mj_setKeyValues(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override  var description: String {

        return "abc"
    }
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        
        aCoder.encode(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String;
        self.expires_in = aDecoder.decodeInteger(forKey: "expires_in")
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        
    }
    
    func saveAccount() -> Bool {
        //序列化保存用户token
        /*
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;

        let filePath = path?.appending("/useraccount.plist");
 
        LYLog(logName: filePath);
 */
        return NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath);
        
    }
    ///定义属性，保存授权模型
    static var userAccount: UserAccount?
    //获取文件路径
    static let filePath:String = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last?.appending("/useraccount.plist"))!
    class func loadUserAccount() -> UserAccount? {
        
        if (userAccount != nil) {
            LYLog(logName: "已经加载过")
            return userAccount;
        }
        LYLog(logName: "还没有加载过")
        /*
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        
        let filePath = path?.appending("/useraccount.plist");
 */
        guard  let account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.filePath) as? UserAccount else {
            return UserAccount.userAccount;
        }
        UserAccount.userAccount = account;
        return UserAccount.userAccount
        
    }
    
    class func isLogin() -> Bool{
        
        //判断用户是否登录
        return UserAccount.loadUserAccount() != nil
        
    }
    
}
