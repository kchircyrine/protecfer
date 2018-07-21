 //
//  DetailProductVC.swift
//  Protecfer
//
//  Created by cyrine on 10/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
 
class DetailProductVC: UIViewController {
    
    //Constraints Outlets
    @IBOutlet weak var generalInfoHeigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var generalDescriptionLbl: UITextView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var articleImage: UIImageView!
    
    var wishlistRepository = WishlistRepository()
    weak var aimableProductController : AimableProductViewController!

   
    var aimableProductArray = [Product]()
    var currentProduct = Product()
    var commentsArray = [Comment]()
    var idProduct = "0"
  
    
    var similarProducts = [Product]()
    var productRepository = ProductRepository()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DetailProductVC.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:  #selector(DetailProductVC.keyboardWillShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailProductVC.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
        let channel = AppPusher.pusher.subscribe("events-channel")
        channel.bind(eventName: "\(String(describing: self.idProduct))", callback: { (data: Any?) -> Void in
             if data != nil {
                do {
                    let test = data as! NSArray
                    self.commentsArray = [Comment]()
                    for item in test {
                        if let data = item as? NSDictionary {
                            let comment = Comment()
                            comment.creationDate = (data["creationDate"] as? String)!
                            comment.text = (data["text"] as? String)!
                            let userComment = data["user"] as! NSDictionary
                            var user = User()
                            user.firstName = userComment["firstName"]! as! String
                            user.lastName = userComment["lastName"]! as! String
                            comment.user = user
                            self.commentsArray.append(comment)
                            
                        }
                    }
                    self.heightCalculation()
                    self.tableView.reloadData()
                }
                
                
                
              
            }
            
        })
         AppPusher.pusher.connect()
        
        
        
        
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
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    
    
    
     func loadContent() {
        let url = APPURL.PRODUCT_URL + "/" + self.idProduct
        Alamofire.request(url).responseJSON { response in
            let result = response.data
            do {
                self.currentProduct = try JSONDecoder().decode(Product.self, from: result!)
                self.showProductDetail()
                self.tableView.reloadData()
                self.tableView.isScrollEnabled = false
                self.setComments()
                self.heightCalculation()
                self.loadAimableProduct()
                self.getContent()
                self.scrollView.setContentOffset(CGPoint(x: 0,y: -self.scrollView.contentInset.top),animated: true)
            }
            catch {
                print("my error")
            }
        }
    }
    
    func showProductDetail () {
        let urlString = APPURL.PRODUCT_PICTURE_URL + (currentProduct._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!) {
            articleImage.image = UIImage(data: data)
        }
        titleLabel.text = self.currentProduct.name
        priceLabel.text = "\(self.currentProduct.price!) DTN"
        colorsLabel.text = self.currentProduct.colors
        referenceLabel.text = self.currentProduct.reference
        generalDescriptionLbl.text = self.currentProduct.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadContent()
    }
    
    func getContent() {
        //        let url = APPURL.PRODUCT_URL + "/" + self.idProduct
        //        Alamofire.request(url).responseJSON { response in
        //            let result = response.data
        //            do {
        //                self.currentProduct = try JSONDecoder().decode(Product.self, from: result!)
        //                self.tableView.reloadData()
        //                self.tableView.isScrollEnabled = false
        //
        //            }
        //            catch {
        //                print("my error")
        //            }
        //        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LikableItems"{
            self.aimableProductController = segue.destination as! AimableProductViewController
            self.aimableProductController.detailVC = self
        }
    }
    
    func loadAimableProduct() {
        Alamofire.request(APPURL.PRODUCT_URL).responseJSON { response in
            let result = response.data
            do {
                self.aimableProductArray = try JSONDecoder().decode([Product].self, from: result!)
                self.aimableProductController.aimableProductArray = self.aimableProductArray
                self.aimableProductController.collectionView.reloadData()
             }
            catch {
                print("error")
            }
        }
    }
    
    @IBAction func likeAction(_ sender: Any) {
        self.addToWishList(reference: self.currentProduct.reference!)
    }
    
    @IBAction func openOrderPop(_ sender: Any) {
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
        } else {
            let storyboard = UIStoryboard(name: "AddOrder", bundle: nil)
            let addOrderViewController = storyboard.instantiateViewController(withIdentifier: "AddOrderPopUpViewController") as! AddOrderPopUpViewController
            addOrderViewController.currentProduct = currentProduct
            self.navigationController?.pushViewController(addOrderViewController, animated: true)
        }
    }
    
    func showLogin () {
        let alert = UIAlertController(title: "Pour effectuer cette action, vous devriez êtres connecté. Voulez-vous vous connecter?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { action in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            myVC.sourceNavigation = true
            self.navigationController?.show(myVC, sender: self)
        }))
        
        self.present(alert, animated: true)
    }
    
    func addToWishList(reference: String) {
        
        if TOKEN.getTOKEN() == "-1" {
            self.showLogin()
            
            
            
        }else{
            var style = ToastStyle()
            wishlistRepository.addWishlist(token:TOKEN.getTOKEN()!, productReference:reference) {
                success in
                if success {
                    print("successful")
                    style.backgroundColor = .blue
                    self.view.makeToast("Cet Article a été ajouté la wishlist", duration: 3.0, position: .bottom, style: style)
                } else {
                    print("not successful")
                    style.backgroundColor = .red
                    self.view.makeToast("Cet Article est déja dans la wishlist", duration: 3.0, position: .bottom, style: style)
                }
            }
        }
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCommentAction(_ sender: Any) {
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
        } else {
        let comment = Comment()
        let commentRepository = CommentRepository()
        comment.text = commentText.text
        comment.product = currentProduct.reference!
        commentRepository.addComment(token: TOKEN.getTOKEN()!, comment: comment) { (response) in
            if response {
                self.commentText.text = ""
                
            }
        }
        }
    }
    
    
    
    
    func heightCalculation() {
        let InfoGeneralFixedHeight : CGFloat = 100
        let generalDescString : String = self.currentProduct.description!
        //self.generalDescriptionLbl.text = generalDescString
        
        let calculGeneralHeight : CGFloat = generalDescString.height(withConstrainedWidth: (self.view.frame.width * 0.95), font: UIFont(name: "Lato-Light", size: 12)!) + InfoGeneralFixedHeight
        
        self.generalInfoHeigthConstraint.constant = calculGeneralHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 131
        self.tableView.reloadData()
        self.commentHeightConstraint.constant = self.estimateTableHeightFromCommentText(commentArray: commentsArray)
        self.view.layoutIfNeeded()
        
    }
    
    
    func estimateTableHeightFromCommentText(commentArray : [Comment]) -> CGFloat {
        var intialHeight : CGFloat = 50
        let fixedHeid : CGFloat = 50
        for item in commentArray {
            let commentHeight : CGFloat = item.text.height(withConstrainedWidth: (self.view.frame.width * 0.95), font: UIFont(name: "Lato-Regular", size: 10)!) + fixedHeid
             intialHeight += commentHeight
            
        }
        
        
        return intialHeight
    }
    
}

 
 //TableView Commentaires
 extension DetailProductVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductCommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentProductCell") as! ProductCommentsTableViewCell
        cell.coment = self.commentsArray[indexPath.row]
        if (self.commentsArray.count - 1) == indexPath.row {
            cell.SeparatoView.isHidden = true
        }else{
            cell.SeparatoView.isHidden = false
        }
        
        return cell
    }
 }

 
 //Dummy data
 extension DetailProductVC {
    func setComments() {
        self.commentsArray = self.currentProduct.comments!
        //print(self.commentsArray)
    }
 }

 
extension DetailProductVC :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
 }



    

    
    



