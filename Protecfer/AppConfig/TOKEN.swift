//
//  TokenApp.swift
//  Protecfer
//
//  Created by cyrine kchir on 12/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import KeychainAccess

struct TOKEN {
    
    
     static let TOKEN_STRING = "token"
     static let EMAIL_STRING = "email"
    
    public static func setTOKEN (token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: TOKEN_STRING )
    }
    
    
    
    public static func getTOKEN () -> String? {
        let token =  UserDefaults.standard.string(forKey: TOKEN_STRING) ?? "-1"
        return token
    }
    
    public static func removeTOKEN () {
        var defaults = UserDefaults.standard
        defaults.removeObject(forKey: TOKEN_STRING)
        defaults.synchronize()
    }
    
    public static func setEMAIL(email:String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: EMAIL_STRING )
        print(email)
    }
    
    public static func getEMAIL () -> String? {
         let email =  UserDefaults.standard.string(forKey: EMAIL_STRING)
         return email
    }
    
    
    
    

}
