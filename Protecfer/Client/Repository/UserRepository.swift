//  Created by cyrine kchir on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol UserProtocolRepository {
    func getUser(token: String,completion: @escaping(User) -> ())
    func updateUser(user: User,completion: @escaping(Bool) -> ())
    func addUser(user: User,completion: @escaping(Bool) -> ())
    func loginUser(email : String, password: String,completion: @escaping(Bool) -> ())
}
class UserRepository: UserProtocolRepository {
    
    let headers = [
        "Authorization": "Bearer \(TOKEN.getTOKEN()! )",
    ]
    
    func updateUser(user: User, completion: @escaping (Bool) -> ()) {
        do {
            let params = try user.asDictionary()
            Alamofire.request(APPURL.BASE_USER_URL , method: .patch, parameters: params, headers:headers ).validate(statusCode: 200..<600).responseJSON { (response) in
                debugPrint(response)
                completion(response.result.isSuccess)
            }
        } catch {
            completion(false)
        }
    }
    
    func addUser(user: User,completion: @escaping(Bool) -> ()) {
        do {
            let params = try user.asDictionary()
            Alamofire.request(APPURL.REGISTER_URL, method: .post, parameters: params).validate(statusCode: 200..<600).responseJSON { (response) in
                 completion(response.result.isSuccess)
            }
        } catch {
             completion(false)
        }
    }
    

    func getUser(token: String,completion: @escaping(User) -> ()) {
        var user = User()
        let url: String = APPURL.GET_USER_URL + token
        Alamofire.request(url, method: .get, headers:headers)
            .responseJSON { response in
                let result = response.data
                do {
                    user = try JSONDecoder().decode(User.self, from: result!)
                    completion(user)
                    
                }
                catch {
                    print("error")
                }
        }
    }
    
    
    func loginUser(email : String, password: String,completion: @escaping(Bool) -> ()) {
         let params: [String: Any] = ["email": email, "password": password]
        Alamofire.request(APPURL.LOGIN_URL, method: .post, parameters: params).validate(statusCode: 200..<600).responseJSON { (response) in
            if let JSON = response.result.value {
                var json = JSON as! [String: Any]
                if let tokenString = json["token"] {
                    TOKEN.setTOKEN(token: tokenString as! String)
                    if let userString =  json["user"] as? [String: String] {
                        TOKEN.setEMAIL(email: userString["email"]!)
                        completion(response.result.isSuccess)
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
 
                    
        
    
    
}
