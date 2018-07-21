//
//  TypeRepository.swift
//  Protecfer
//
//  Created by Zouari on 07/06/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol TypeProtocolRepository {
    func getTypes(completion:@escaping([Type]) -> ())
}

class TypeRepository: TypeProtocolRepository {
    func getTypes(completion: @escaping ([Type]) -> ()) {
        var types = [Type]()
        Alamofire.request(APPURL.ACTIVE_TYPES_URL, method: .get)
            .responseJSON { response in
                //debugPrint(response)
                let result = response.data
                do {
                    types = try JSONDecoder().decode([Type].self, from: result!)
                    completion(types)
                }
                catch {
                    print("error")
                }
        }
    }
    

}
