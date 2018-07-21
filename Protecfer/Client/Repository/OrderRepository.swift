//  CartRepository.swift
//  Protecfer
//  Created by cyrine kchir on 12/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol OrderProtocolRepository {
    func getOrder(token: String,completion:@escaping(Order) -> ())
    func removeOrderlineFromOrder (id:String,completion:@escaping(Bool) -> ())
    func validateOrder (reference:String,completion:@escaping(Bool) -> ())
}



class OrderRepository: OrderProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )"
    ]
    
    func validateOrder(reference: String, completion: @escaping (Bool) -> ()) {
         let url: String = APPURL.ORDER_PDF_URL + reference
        Alamofire.request(url, method: .patch, headers:headers)
            .responseJSON { response in
                //debugPrint(response)
                completion(response.result.isSuccess)
        }
    }
    
    
    // MARK: remove orderline from order
    func removeOrderlineFromOrder(id: String, completion: @escaping (Bool) -> ()) {
        let url: String = APPURL.ORDERLINES_URL + id + "/" + TOKEN.getTOKEN()!
        Alamofire.request(url, method: .delete, headers:headers)
            .responseJSON { response in
                debugPrint(response)
                completion(response.result.isSuccess)
        }
    }
    
    
    // MARK: get order by users
    func getOrder(token: String,completion:@escaping(Order) -> ()) {
        var order = Order()
        let url: String = APPURL.ORDERLINES_URL + token
       
        Alamofire.request(url, method: .get, headers:headers)
            .responseJSON { response in
                debugPrint(response)
                let result = response.data
                do {
                    order = try JSONDecoder().decode(Order.self, from: result!)
                   completion(order)
                }
                catch {
                    print("error")
                 }
         }
     }
    
    
    
    
    
    
    
    
    
    
    
}
    
    
    
    
    

