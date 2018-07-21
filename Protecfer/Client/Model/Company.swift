//
//  Company.swift
//  Protecfer
//
//  Created by cyrine kchir on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Company: Codable {
    let _id: String?
    let name: String?
    let address: Address?
    let telephoneNumber: String?
    let email: String?
    let beginOpenDay: String?
    let endOpenDay: String?
    let closeTime: String?
    let openTime: String?
    
    init() {
        _id = "0"
        name = ""
        address = nil
        telephoneNumber = ""
        email = ""
        beginOpenDay = ""
        endOpenDay = ""
        closeTime = ""
        openTime = ""
    }
}
