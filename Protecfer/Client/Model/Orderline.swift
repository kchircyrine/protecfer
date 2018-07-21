//
//  OrderLine.swift
//  Protecfer
//
//  Created by cyrine kchir on 12/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Orderline: Codable {
    
    var _id: String?
    var height: Float
    var product: Product
    var quantity: Int
    var thickness: Float
    var width: Float
    var order: String?
    var tokenUser: String?
    
    init() {
        self._id = "0"
        self.quantity = 0
        self.height = 0
        self.width = 0
        self.thickness = 0
        self.product = Product()
        self.order = nil
        //order = Order ()
    }
    
    
    func asDictionary() throws -> [String: Any] {
        return[
            "token" : self.tokenUser!,
            "productReference": self.product.reference!,
            "width": self.width,
            "height": self.height,
            "thickness": self.thickness,
            "quantity": self.quantity
        ]
       
  }
    
    func fromDicToObject(orderLineDic: NSDictionary) {
        self._id = orderLineDic["_id"] as? String
        self.quantity = (orderLineDic["quantity"] as? Int)!
        self.height = (orderLineDic["height"] as? Float)!
        self.width = (orderLineDic["width"] as? Float)!
        self.thickness = (orderLineDic["thickness"] as? Float)!
        let productDic = orderLineDic["product"] as? NSDictionary
        let product = Product()
        product._id = (productDic?["_id"] as! String)
        product.reference = (productDic?["reference"] as! String)
        product.name = (productDic?["name"] as! String)
        product.price = (productDic?["price"] as! Float)
        self.product = product
    }
    
    

}
