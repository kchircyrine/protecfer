//
//  Product.swift
//  Protecfer
//
//  Created by cyrine kchir on 08/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Product: Codable {
    var _id: String?
    var name: String?
    var price: Float?
    var category: Category?
    var reference: String?
    var description: String?
    var colors: String?
    var active: Bool?
    var comments: [Comment]?
    
    init() {
       _id = nil
       name = "0"
       price = 0
       reference = "0"
       category = Category()
       description = "0"
       colors = ""
       active = true
       comments = []
    }
}
