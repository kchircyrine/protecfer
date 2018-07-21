//
//  OrderlineRepository.swift
//  Protecfer
//
//  Created by cyrine kchir on 14/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

import Alamofire

protocol OrderLineProtocolRepository {
    func addOrderline(orderline: Orderline,completion:@escaping(Bool) -> ())
    
}

class OrderlineRepository: OrderLineProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )",
    ]
    
    func addOrderline(orderline: Orderline,completion:@escaping(Bool) -> ()) {
                do {
                    let params = try orderline.asDictionary()
                    print("hossein")
                    print(params)
                    Alamofire.request(APPURL.ORDERLINES_URL, method: .post, parameters: params, headers: headers).validate(statusCode: 200..<600).responseJSON { (response) in
                        debugPrint(response)
                    }
                } catch { }
        
    }

}
