//  MessageViewController.swift
//  Protecfer
//  Created by cyrine on 15/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class MessageViewController: UIViewController {

    var message = Message ()
    var messageRepository = MessageRepository ()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var objectTextField: UITextField!
    
    @IBAction func writeMessageAction(_ sender: Any) {
        self.setInformationMessage()
        messageRepository.addMessage(token: TOKEN.getTOKEN()!, message: message) { (response) in
            var style = ToastStyle()
            if (response) {
                style.backgroundColor = .blue
                self.view.makeToast("Votre message a été envoyé", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
                self.messageTextField.text = ""
                self.objectTextField.text = ""
            } else{
                style.backgroundColor = .red
                self.view.makeToast("Erreur lors de l'envoi du message", duration: 3.0, position: .bottom, style: style)
                self.DismissKeyboard()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.text = TOKEN.getEMAIL()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MessageViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
    }
    
    func setInformationMessage () {
        message.text = self.messageTextField.text
        message.object = self.objectTextField.text!
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}

