//
//  Address.swift
//  Protecfer
//
//  Created by cyrine on 08/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Address: Codable {
    var city: String
    var zip: String
    var street: String
    var longitude: Double?
    var latitude: Double?
    
    init(city: String, zip: String, street: String ) {
        self.city = city
        self.zip = zip
        self.street = street
    }
    
    init() {
        self.city = ""
        self.zip = ""
        self.street = ""
    }
    
    
}
