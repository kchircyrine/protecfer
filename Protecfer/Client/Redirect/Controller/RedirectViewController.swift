//
//  RedirectViewController.swift
//  Protecfer
//  Created by cyrine on 08/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class RedirectViewController: UIViewController {

    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var listContainerView: UIView!
    
    struct STORYBOARD {
        static let LOGIN_SEGUE = "loginSegue"
        static let LIST_USER_SEGUE = "listUserSegue"
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     func hideContent() {
        if((TOKEN.getTOKEN()) != "-1") {
            loginContainerView.alpha = 0
            listContainerView.alpha = 1
        }else {
            loginContainerView.alpha = 1
            listContainerView.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideContent()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == STORYBOARD.LOGIN_SEGUE{
            let vc = segue.destination as! LoginVC
            vc.parentVC = self
        }else if segue.identifier == STORYBOARD.LIST_USER_SEGUE {
            let vc = segue.destination as! ConnectedUserViewController
            vc.parentVC = self
        }
    }

}
