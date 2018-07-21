//
//  CategoryRepository.swift
//  Protecfer
//
//  Created by cyrine kchir on 16/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol CategoryProtocolRepository {
    func getCategories(completion:@escaping([Category]) -> ())
}

class CategoryRepository: CategoryProtocolRepository {
    
    func getCategories(completion: @escaping ([Category]) -> ()) {
        var categories = [Category]()
        Alamofire.request(APPURL.CATEGORIES_PARENT_URL, method: .get)
            .responseJSON { response in
                //debugPrint(response)
                let result = response.data
                do {
                    categories = try JSONDecoder().decode([Category].self, from: result!)
                    completion(categories)
                }catch {
                    print("error")
                }
        }
        
    }
    
    
}
