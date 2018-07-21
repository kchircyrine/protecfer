//
//  CompanyRepository.swift
//  Protecfer
//
//  Created by cyrine kchir on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire

protocol CompanyProtocolRepository {
    func getCompany(completion:@escaping(Company) -> ())
   
}

class CompanyRepository: CompanyProtocolRepository {
    
    // MARK: get company
    func getCompany(completion:@escaping(Company) -> ()) {
        var company = Company ()
        let url: String = APPURL.COMPANY_URL
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                let result = response.data
                do {
                    company = try JSONDecoder().decode(Company.self, from: result!)
                    completion(company)
                }
                catch {
                    print("error")
                }
        }
    }

}
