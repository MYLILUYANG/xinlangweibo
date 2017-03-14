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
}
