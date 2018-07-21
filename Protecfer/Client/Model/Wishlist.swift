//  Wishlist.swift
//  Protecfer
//  Created by cyrine kchir on 11/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.

import UIKit

class Wishlist: Codable {
    var _id: String
    let product: Product?
    let user: String?
    
    init(id: String, product: Product) {
        self._id = id
        self.product = product
        self.user = nil
    }
    
     init() {
        self._id = "0"
        self.product = nil
        self.user = nil
    }
    
    func parseWishlist (wishlistParse : NSDictionary) {
        let product = Product()
        let productDic = wishlistParse["product"] as? NSDictionary
        self.product?.reference = productDic!["reference"] as? String
        self.product?.description = productDic!["description"] as? String
        self.product?._id = productDic!["_id"] as? String
        self.product?.name = productDic!["name"] as? String
        self.product?.price = productDic!["price"] as? Float
        self._id = (wishlistParse["_id"] as? String)!
        
    }
}



