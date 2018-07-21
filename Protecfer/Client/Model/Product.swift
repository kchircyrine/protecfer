//
//  Product.swift
//  Protecfer
//
//  Created by cyrine on 08/01/2018.
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
     var type: String?
    
    init() {
       _id = nil
       name = "0"
       price = 0
       reference = "0"
       category = Category()
       type = ""
       description = "0"
       colors = ""
       active = true
       comments = []
    }
  
    func parseProduct (productDictionnary: NSDictionary)  {
        
        let categoryDic = productDictionnary["category"] as? NSDictionary
        let nameCategory = categoryDic!["name"]  as? String
        let idCategory = categoryDic!["_id"]  as? String
        let parentCategory = categoryDic!["parent"]  as? Bool
        let type = productDictionnary["type"]  as? String
        let category = Category(_id: idCategory!, name: nameCategory!, parent: parentCategory!)

        self.category = category
        self.type = type
        self.reference = productDictionnary["reference"] as? String
        self.price = productDictionnary["price"] as? Float
        self.type = productDictionnary["type"] as? String
        self.description = productDictionnary["description"] as? String
        self._id = productDictionnary["_id"] as? String
        self.name = productDictionnary["name"] as? String
    }
    
}
