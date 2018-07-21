//
//  ConnectedUserViewController.swift
//  Protecfer
//  Created by cyrine on 03/01/18.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class ConnectedUserViewController: UIViewController {
    weak var parentVC : RedirectViewController?
    
    struct STORYBOARD {
        static let WISHLIST = "Wishlist"
        static let ORDERS = "Orders"
        static let MESSAGE = "Message"
        static let UPDATE_PROFILE = "UpdateProfile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func souhaitAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: STORYBOARD.WISHLIST, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController()
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    @IBAction func commandeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: STORYBOARD.ORDERS, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController()
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    @IBAction func messageAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: STORYBOARD.MESSAGE, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController() as! MessageViewController
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: STORYBOARD.UPDATE_PROFILE, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController() as! UpdateProfileViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    @IBAction func deconnexionAction(_ sender: Any) {
        TOKEN.removeTOKEN()
        self.parentVC?.hideContent()
    }
    
}


