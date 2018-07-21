//
//  ProductRepository.swift
//  Protecfer
//
//  Created by cyrine kchir on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol ProductProtocolRepository {
    func getLastProducts(completion:@escaping([Product]) -> ())
    func getSimilarProducts(id:String,completation:@escaping([Product]) -> ())
    func getAllProducts(completion:@escaping([Product]) -> ())
}

class ProductRepository: ProductProtocolRepository {
    
    func getLastProducts(completion: @escaping ([Product]) -> ()) {
        var lastProducts = [Product]()
        Alamofire.request(APPURL.LAST_PRODUCTS_URL, method: .get)
            .responseJSON { response in
                //debugPrint(response)
                let result = response.data
                do {
                    lastProducts = try JSONDecoder().decode([Product].self, from: result!)
                    completion(lastProducts)
                }catch {
                    print("error")
                }
        }
    }
    
    func getSimilarProducts(id:String, completation completion: @escaping ([Product]) -> ()){
        var similarProducts = [Product]()
        Alamofire.request(APPURL.SIMILAR_PRODUCTS_URL + id, method: .get)
            .responseJSON { response in
               debugPrint(response)
                let result = response.data
                do {
                    similarProducts = try JSONDecoder().decode([Product].self, from: result!)
                    completion(similarProducts)
                }catch {
                    print("error")
                }
        }
        
    }
    
    func getFullProducts()-> [Product] {
        var products = [Product]()
        Alamofire.request(APPURL.PRODUCT_URL).responseJSON { response in
            let result = response.data
            do {
                products = try JSONDecoder().decode([Product].self, from: result!)
            }
            catch {
                print("error")
            }
        }
        return products
    }
    
    
    func getAllProducts(completion: @escaping ([Product]) -> ()){
        var products = [Product]()
        Alamofire.request(APPURL.PRODUCT_URL).responseJSON { response in
            let result = response.data
            do {
                products = try JSONDecoder().decode([Product].self, from: result!)
                completion(products)
            }
            catch {
                print("error")
            }
        }
    }
    
    

}
