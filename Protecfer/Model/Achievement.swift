//
//  Achievement.swift
//  Protecfer
//  Created by cyrine kchir on 16/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

struct Achievement: Codable {
    let _id: String?
    let title: String?
    let description: String?
    let picture: String?
    
    init() {
        _id = "0"
        title = ""
        description = ""
        picture = ""
    }
    
    
}
