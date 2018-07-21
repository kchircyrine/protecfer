//  MessageRepository.swift
//  Protecfer
//  Created by cyrine kchir on 15/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol MessageProtocolRepository {
    func addMessage(token:String,message: Message,completion:@escaping(Bool) -> ())
}

class MessageRepository: MessageProtocolRepository {
    
    func addMessage(token:String ,message: Message, completion: @escaping (Bool) -> ()) {
        do {
            let params = try message.asDictionary(token: token)
            print(params)
            Alamofire.request(APPURL.MESSAGE_URL, method: .post, parameters: params).validate(statusCode: 200..<600).responseJSON { (response) in
                //debugPrint(response)
            }
        } catch { }
    }
    

}
