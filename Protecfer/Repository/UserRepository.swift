//  Created by cyrine kchir on 13/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol UserProtocolRepository {
    func getUser(token: String,completion: @escaping(User) -> ())
    func updateUser(user: User,completion: @escaping(Bool) -> ())
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
            }
        } catch {
            print("yes")
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
    
}
