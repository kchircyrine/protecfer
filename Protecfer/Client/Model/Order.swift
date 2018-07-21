//
//  Order.swift
//  Protecfer
//
//  Created by cyrine kchir on 12/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Order: Codable {
    
    var _id: String
    //var state: Int?
    var reference: String
    var active: Bool?
    var orderLines: [Orderline]
    var user: String?
    
    init() {
        self._id = "_id"
        //self.state = 0
        self.reference = ""
        self.active = true
        self.orderLines = []
        self.user = nil
    }
    
    init(_id: String, state: Int, reference: String, active: Bool) {
        self._id = _id
        //self.state = state
        self.reference = reference
        self.active = active
        self.orderLines = []
        self.user = nil
    }
    
    
}


