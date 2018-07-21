//
//  Category.swift
//  Protecfer
//
//  Created by cyrine kchir on 08/01/2018.
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
    
    init (_id: String, name: String, parent: Bool){
        self._id = _id
        self.name = name
        self.parent = parent
    }
    

}
