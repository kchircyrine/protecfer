//
//  RegisterVC.swift
//  Protecfer
//
//  Created by cyrine kchir on 09/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class RegisterVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    // Constraints
    //@IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    let userRepository = UserRepository()
    
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //_=getAllTextFields(fromView : self.view).map{($0.delegate = self)}
        
        // Add touch gesture for contentView
        // Register to be notified if the keyboard is changing size
         NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(RegisterVC.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
      
    }
    
    deinit {
        // Don't have to do this on iOS 9+, but it still works
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        // Pull a bunch of info out of the notification
        if let scrollView = scrollView, let userInfo = notification.userInfo, let endValue = userInfo[UIKeyboardFrameEndUserInfoKey], let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] {
            
            // Transform the keyboard's frame into our view's coordinate system
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            
            // Find out how much the keyboard overlaps the scroll view
            // We can do this because our scroll view's frame is already in our view's coordinate system
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            
            // Set the scroll view's content inset to avoid the keyboard
            // Don't forget the scroll indicator too!
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
            
            let duration = (durationValue as AnyObject).doubleValue
            UIView.animate(withDuration: duration!, delay: 0, options: .beginFromCurrentState, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    /*func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }*/
    
    @IBAction func registerAction(_ sender: Any) {
        let address = Address(city: cityTextField.text!, zip: zipTextField.text! , street: addressTextField.text!)
        let user = User(email: emailTextField.text! , password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, telephoneNumber:lastNameTextField.text! , address: address)
        self.register(user:user)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

// MARK: - Networking calls
extension RegisterVC {
    
    func register(user : User) {
        userRepository.addUser(user: user) { response in
            var style = ToastStyle()
            if (response) {
                style.backgroundColor = .blue
                self.view.makeToast("Veuillez valider votre compte", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
            } else{
                style.backgroundColor = .red
                self.view.makeToast("Erreur lors de la création du compte", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
            }
        }
    }
}


extension RegisterVC :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    
}
