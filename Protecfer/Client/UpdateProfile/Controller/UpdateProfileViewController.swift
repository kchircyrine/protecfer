//
//  UpdateProfileViewController.swift
//  Protecfer
//  Created by cyrine on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
     @IBOutlet weak var scrollView: UIScrollView!
    
    var userRepository = UserRepository()
    var user = User ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(TOKEN.getTOKEN()!)
        userRepository.getUser(token: TOKEN.getTOKEN()!) { (user) in
             self.user = user
            self.setInformationView(user: user)
        }
        _=getAllTextFields(fromView : self.view).map{($0.delegate = self)}
        
        // Add touch gesture for contentView
        // Register to be notified if the keyboard is changing size
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateProfileViewController.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(UpdateProfileViewController.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdateProfileViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
    }
    
    deinit {
        // Don't have to do this on iOS 9+, but it still works
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func updateProfileAction(_ sender: Any) {
        self.setInformationUser()
        userRepository.updateUser(user: user) { (response) in
            var style = ToastStyle()
            if (response) {
                style.backgroundColor = .blue
                self.view.makeToast("Votre profil a été modifié ", duration: 3.0, position: .bottom, style: style)
            } else{
                style.backgroundColor = .red
                self.view.makeToast("Erreur lors de la modification", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
            }
        }
    }
     
    
    func setInformationView(user: User){
       firstNameTextField.text = user.firstName
       lastNameTextField.text = user.lastName
       emailTextField.text = user.email
       cityTextField.text = user.address?.city
       zipCodeTextField.text = user.address?.zip
       addressTextField.text = user.address?.street
       telephoneTextField.text = user.telephoneNumber
    }
    
    func setInformationUser(){
        self.user.firstName! = firstNameTextField.text!
        self.user.lastName! = lastNameTextField.text!
        self.user.email! = emailTextField.text!
        self.user.address?.city = cityTextField.text!
        self.user.address?.zip = zipCodeTextField.text!
        self.user.address?.street = addressTextField.text!
        self.user.telephoneNumber = telephoneTextField.text
    }
    
    
    
}


extension UpdateProfileViewController {
    
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
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
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
}

extension UpdateProfileViewController :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
