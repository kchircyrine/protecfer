//  MessageRepository.swift
//  Protecfer
//  Created by cyrine kchir on 15/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol MessageProtocolRepository {
    func addMessage(token:String,message: Message,completion:@escaping(Bool) -> ())
}

class MessageRepository: MessageProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )",
    ]
    
    func addMessage(token:String ,message: Message, completion: @escaping (Bool) -> ()) {
        do {
            let params = try message.asDictionary(token: token)
            Alamofire.request(APPURL.MESSAGE_URL, method: .post, parameters: params,headers:headers).validate(statusCode: 200..<600).responseJSON { (response) in
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    

}
