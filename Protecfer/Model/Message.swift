//
//  Message.swift
//  Protecfer
//
//  Created by cyrine kchir on 15/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Message: Codable {
    
    var _id: String
    var object: String
    var text: String
    var state: Bool
    var creationDate: Date
    var messageParent: String
    var sender: String
    var receiver: String
    
    init() {
        _id = "0"
        object = ""
        text = ""
        state = true
        creationDate = Date()
        messageParent = ""
        sender = ""
        receiver = ""
    }
    
    func asDictionary(token: String) throws -> [String: Any] {
        return[
            "object" : self.object,
            "text": self.text,
            "state": self.state,
            "creationDate": self.creationDate,
            "messageParent": self.messageParent,
            "token": token
        ]
    }

}
