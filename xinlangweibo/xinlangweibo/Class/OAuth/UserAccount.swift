//
//  UserAccount.swift
//  xinlangweibo
//
//  Created by liluyang on 2017/3/14.
//  Copyright © 2017年 liluyang. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    //令牌
    var access_token:String?
    //过期时间，从授权那一刻开始，多少秒后过期时间
    var expires_in:Int = 0
        {
        didSet{
            
            expires_Date = NSDate(timeIntervalSinceNow: TimeInterval(expires_in))
            
        }
    }
    //用户ID
    var uid: String?
    //真正过期时间
    var expires_Date:NSDate?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    // 用户昵称
    var screen_name:String?
    
    
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
        aCoder.encode(expires_Date, forKey: "expires_Date")
        aCoder.encode(avatar_large, forKey: "avatar_large");
        aCoder.encode(screen_name, forKey: "screen_name")
    }

    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String;
        self.expires_in = aDecoder.decodeInteger(forKey: "expires_in")
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as? NSDate
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String;
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String;
    }
    
    func saveAccount()
    {
        //序列化保存用户token
         NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath);
        
    }
    ///定义属性，保存授权模型
    static var userAccount: UserAccount?
    //获取文件路径
    static let filePath = "/useraccount.plist".cachesDir()
    
    class func loadUserAccount() -> UserAccount? {
        
        if (userAccount != nil) {
            LYLog(logName: "已经加载过")
            return userAccount;
        }
        LYLog(logName: "还没有加载过")

        guard  let account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.filePath) as? UserAccount else {
            return UserAccount.userAccount;
        }
        
        //校验是否token过期
        guard let date = account.expires_Date, date.compare(NSDate() as Date) != ComparisonResult.orderedAscending else {
            LYLog(logName: "令牌过期了");
            return nil;
        }
        

        UserAccount.userAccount = account;
        return UserAccount.userAccount
        
    }
    
    class func isLogin() -> Bool{
        
        //判断用户是否登录
        return UserAccount.loadUserAccount() != nil
        
    }
    
    //请求用户信息
    func loadUserInfo(finished:@escaping (_ account: UserAccount?, _ error: NSError?)->())
    {
        //断言
        //断言 access_token一定是不等于nil的，如果运行accesstoken 等于nil 那么程序就会崩溃，并且报错
        assert(access_token != nil, "使用该方法必须先授权")
        assert(uid != nil, "使用该方法必须现获取uId")
        // https://api.weibo.com/2/users/show.json
        let getUrl = "https://api.weibo.com/2/users/show.json"
        //准备请求参数
        let parames = [
            "access_token":access_token!,
            "uid":uid!,
            ]
        //发送post 请求
        NetWorkTools.shareInstance.get(getUrl, parameters: parames, progress: { (progress) in
            
        }, success: { (task, objc) in

            let dict = objc as! [String: AnyObject]
            // 取出用户信息
            self.avatar_large = dict["avatar_large"] as? String;
            self.screen_name = dict["screen_name"] as? String;
            //保存授权信息
            
            finished(self, nil);
            
        }) { (task, error) in
            finished(nil, error as NSError);
        }
    }
}
