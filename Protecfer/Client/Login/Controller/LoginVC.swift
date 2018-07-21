//
//  LoginVC.swift
//  Protecfer
//  Created by cyrine on 22/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import Toast_Swift

class LoginVC: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var sourceNavigation : Bool = false
    
    let userRepository = UserRepository()
    
    weak var parentVC : RedirectViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
        passwordTextField.delegate = self
        emailTextField.delegate = self

        if sourceNavigation{
            self.backButton.isHidden = false
        }else{
            self.backButton.isHidden = true
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

   
    @IBAction func signInAction(_ sender: Any) {
        login(email: emailTextField.text!, password: passwordTextField.text!)
        
    }

    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.DismissKeyboard()
    }
    
}

// MARK: - Networking calls
extension LoginVC {
    func login(email : String, password: String){
        userRepository.loginUser(email: email, password: password) { (response) in
            if (response){
                var style = ToastStyle()
                style.backgroundColor = .blue
                self.view.makeToast("Utilisateur authnetifié", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
                
                if (self.sourceNavigation) {
                    self.navigationController?.popViewController(animated: true)
                }else {
                    self.parentVC?.hideContent()
                }
            }else {
                self.DismissKeyboard()
                var style = ToastStyle()
                style.backgroundColor = .red
                self.view.makeToast("Erreur lors du login", duration: 3.0, position: .bottom, style: style)
            }
        }
       }
}

extension LoginVC :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
