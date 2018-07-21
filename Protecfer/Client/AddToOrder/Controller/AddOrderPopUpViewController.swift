//
//  AddOrderViewController.swift
//  Protecfer
//  Created by cyrine on 14/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class AddOrderPopUpViewController: UIViewController {

    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var priceOrderBeforeTax: UILabel!
    @IBOutlet weak var productThicknessTextField: UITextField!
    @IBOutlet weak var productWidthTextField: UITextField!
    @IBOutlet weak var productHeightTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productQuantityLabel: UITextField!
    var currentProduct = Product()
    var orderlineRepository = OrderlineRepository()
    var currentOrderline = Orderline()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setInformationProduct()
        _=getAllTextFields(fromView : self.view).map{($0.delegate = self)}
        
        // Add touch gesture for contentView
        // Register to be notified if the keyboard is changing size
        NotificationCenter.default.addObserver(self, selector: #selector(AddOrderPopUpViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AddOrderPopUpViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddOrderPopUpViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func validateOrder(_ sender: Any) {
        self.setInformationOrder()
         currentOrderline.tokenUser = TOKEN.getTOKEN()
         var style = ToastStyle()
        orderlineRepository.addOrderline(orderline: currentOrderline) { success in
            print(success)
            if success {
                style.backgroundColor = .blue
                self.view.makeToast("Cet Article a été ajouté au panier", duration: 3.0, position: .bottom, style: style)
                 DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                   self.navigationController?.popViewController(animated: true)
                }
            } else {
                print("not successful")
                style.backgroundColor = .red
                self.view.makeToast("Cet Article est déja dans la wishlist", duration: 3.0, position: .bottom, style: style)
            }
           
            
        }
    }
    
    @IBAction func generatePriceAction(_ sender: Any) {
        if (self.setInformationOrder()) {
            print(currentOrderline.product.price!)
            let priceTax = currentProduct.price! * 0.19
            let priceDelivery = currentProduct.price! * 0.1
            let priceTotal = priceTax + priceDelivery + currentProduct.price!
            self.priceLabelGenerated.text = "\(priceTotal) TND"
        }else {
            var style = ToastStyle()
                style.backgroundColor = .blue
                self.view.makeToast("Veuillez vérifier les champs", duration: 3.0, position: .bottom, style: style)
        }
    }
    
    @IBOutlet weak var priceLabelGenerated: UILabel!
    func setInformationProduct () {
        productTitleLabel.text = currentProduct.name
        productPriceLabel.text = "\(currentProduct.price!) DTN"
        let urlString = APPURL.PRODUCT_PICTURE_URL + (currentProduct._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!)
        {
            productImageView.image = UIImage(data: data)
        }
    }
    
   func setInformationOrder() -> Bool {
    var test : Bool = false
    currentOrderline.product.reference = currentProduct.reference
    if let width = productWidthTextField.text, let height = productHeightTextField.text,
        let thickness = productThicknessTextField.text, let quantity = productQuantityLabel.text{
        let widthProdcut = (width as NSString).floatValue
        let heightProduct = (height as NSString).floatValue
        let thicknessProduct = (thickness as NSString).floatValue
        let quantityProduct = (quantity as NSString).integerValue
        
        if widthProdcut > 0 && heightProduct > 0 && thicknessProduct > 0 && quantityProduct > 0{
            currentOrderline.width = widthProdcut
            currentOrderline.height = heightProduct
            currentOrderline.thickness = thicknessProduct
            currentOrderline.quantity = quantityProduct
            test = true
        } else{
            test = false
        }
    }
    return test
    }
}



extension AddOrderPopUpViewController {
    
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    
}

extension AddOrderPopUpViewController :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
