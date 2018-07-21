//
//  WishlistRepository.swift
//  Protecfer
//
//  Created by cyrine kchir on 12/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire


protocol WishlistProtocolRepository{
    func removeFromWishlist(id:String,completion:@escaping(Bool) -> ())
    func getWishlist(completion:@escaping([Wishlist]) -> ())
}


class WishlistRepository: WishlistProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )",
    ]
    
    func getWishlist(completion: @escaping ([Wishlist]) -> ()) {
        var wishlist = [Wishlist]()
        let urlString = APPURL.WISHLIST_URL + TOKEN.getTOKEN()!
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            let result = response.data
            do {
                wishlist = try JSONDecoder().decode([Wishlist].self, from: result!)
                completion(wishlist)
            }catch {
                print("error")
            }
        }
    }
    
    // MARK: Remove item from Wishlist
    func removeFromWishlist(id: String, completion:@escaping (Bool) -> ()) {
        let url: String = APPURL.WISHLIST_URL + id + "/" + TOKEN.getTOKEN()!
        Alamofire.request(url, method: .delete, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                    completion(response.result.isSuccess)
           }
    }
    
    // MARK: Add item to Wishlist
    func  addWishlist(token:String, productReference:String, completion:@escaping (Bool) -> ()) {
        let url: String = APPURL.WISHLIST_URL
        let params = [ "token": token , "productReference": productReference]
        Alamofire.request(url, method: .post, parameters: params, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                completion(response.result.isSuccess)
        }
    }
    
    
    
    
    
    
        
}

    
    
   

