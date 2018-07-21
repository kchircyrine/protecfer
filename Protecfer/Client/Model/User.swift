//
//  User.swift
//  Protecfer
//
//  Created by cyrine on 08/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

struct User: Codable {
    var _id: String
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var telephoneNumber: String?
    var token: String?
    var address: Address?
    
    init() {
        self.email = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.telephoneNumber = ""
        self.address = Address()
        self.token = ""
        self._id = ""
    }
    
    init(email: String,password: String, firstName: String, lastName: String, telephoneNumber: String, address: Address) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.telephoneNumber = telephoneNumber
        self.address = address
        self.token = ""
        self._id = ""
    }
    
    func asDictionary() throws -> [String: Any] {
      return[
        "_id" : self._id,
        "email": self.email!,
        "password": self.password!,
         "firstName": self.firstName!,
         "lastName": self.lastName!,
         "telephoneNumber": self.telephoneNumber!,
         "address":[
            "city": self.address!.city,
            "zip":self.address!.zip,
            "street": self.address!.street
            ]
      ]
    }

}


