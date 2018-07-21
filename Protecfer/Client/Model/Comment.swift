//
//  Comment.swift
//  Protecfer
//
//  Created by Zouari on 02/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Comment: Codable {
    
    var _id: String?
    var text: String
    var state: Bool?
    var user: User?
    var creationDate: String?
    var product: String
    
    init() {
        _id = "0"
        text = ""
        state = false
        user = nil
        creationDate = ""
        product = ""
    }
    
    func asDictionary(token: String) throws -> [String: Any] {
        return[
            "text": self.text,
            "product": self.product,
            "token": token
        ]
    }

}
