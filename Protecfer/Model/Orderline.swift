//
//  OrderLine.swift
//  Protecfer
//
//  Created by cyrine kchir on 12/04/2018.
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
    
    

}
