//
//  CommentRepository.swift
//  Protecfer
//
//  Created by Zouari on 02/05/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol CommentProtocolRepository {
    func addComment(token:String,comment: Comment,completion:@escaping(Bool) -> ())
}
class CommentRepository: CommentProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )",
    ]
    
    func addComment(token: String, comment: Comment, completion: @escaping (Bool) -> ()) {
        do {
            let params = try comment.asDictionary(token: token)
            print(params)
            Alamofire.request(APPURL.COMMENT_URL, method: .post, parameters: params, headers:headers ).validate(statusCode: 200..<600).responseJSON { (response) in
                print("***************************************")
                debugPrint(response)
                print("***************************************")
            }
        } catch { }
    }
    
    
   
    

}
