//
//  AchievementRepository.swift
//  Protecfer
//
//  Created by Zouari on 07/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol AchievementProtcolRepository {
    func getActiveAchievements(completion:@escaping([Achievement]) -> ())
}

class AchievementRepository: AchievementProtcolRepository {
    
    func getActiveAchievements(completion: @escaping ([Achievement]) -> ()) {
        var achievements = [Achievement]()
        Alamofire.request(APPURL.ACTIVE_ACHIEVEMENT_URL, method: .get)
            .responseJSON { response in
               // debugPrint(response)
                let result = response.data
                do {
                    achievements = try JSONDecoder().decode([Achievement].self, from: result!)
                    completion(achievements)
                }catch {
                    print("error")
                }
        }
    }
    

}
