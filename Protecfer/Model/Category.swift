//
//  Category.swift
//  Protecfer
//
//  Created by cyrine kchir on 08/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
struct Category: Codable {
    let _id: String?
    let name: String?
    let parent: Bool?
    //var test: Box<Category>?
    
    init() {
        _id = "0"
        name = "0"
        parent = true
    }
    

}
