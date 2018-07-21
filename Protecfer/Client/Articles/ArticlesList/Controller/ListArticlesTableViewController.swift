//
//  ListArticlesTableViewController.swift
//  Protecfer
//  Created by cyrine on 01/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class ListArticlesTableViewController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    
    private let reuseIdentifierCellTable = "articleTable"
    
    struct STORYBOARD {
        static let DETAIL_PRODUCT  = "DetailProduct"
        static let ADD_ORDER = "AddOrder"
        static let LOGIN = "Login"
    }
    
    var wishlistRepository = WishlistRepository()
    var wishlist = [Wishlist]()
    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesTableView.delegate = self
        self.articlesTableView.dataSource = self
        self.articlesTableView.reloadData()
    }
}

extension ListArticlesTableViewController : UITableViewDelegate,UITableViewDataSource, ArticleTableViewCellDelegate {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCellTable, for: indexPath) as! ArticleTableViewCell
        cell.product = productArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            UIView.animate(withDuration: 1.0, animations: {
                cell.layer.transform = CATransform3DIdentity
            })
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 260;
    }
    
    func openArticlePopupView(product: Product) {
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
        } else {
        let storyboard = UIStoryboard(name: STORYBOARD.ADD_ORDER, bundle: nil)
        let addOrderViewController = storyboard.instantiateInitialViewController() as! AddOrderPopUpViewController
        addOrderViewController.currentProduct = product
        self.navigationController?.pushViewController(addOrderViewController, animated: true)
        }
    }
    
    func showLogin() {
        let alert = UIAlertController(title: "Pour effectuer cette action, vous devriez êtres connecté. Voulez-vous vous connecter?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { action in
            let storyboard = UIStoryboard(name: STORYBOARD.LOGIN, bundle: nil)
            let myVC = storyboard.instantiateInitialViewController() as! LoginVC
            myVC.sourceNavigation = true
            self.navigationController?.show(myVC, sender: self)
        }))
        
        self.present(alert, animated: true)
    }
    
    
    func articleTableViewCellWishlist(_ sender: ArticleTableViewCell, productReference:String) {
        
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
        } else {
            var style = ToastStyle()
            wishlistRepository.addWishlist(token:TOKEN.getTOKEN()!, productReference:productReference) {
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
    
    
    
    func didOpenDetail(product: Product) {
        let storyboard = UIStoryboard(name: STORYBOARD.DETAIL_PRODUCT, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController() as! DetailProductVC
        myVC.idProduct = product._id!
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
 
}
