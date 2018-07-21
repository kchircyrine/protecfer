//
//  LastProductsViewController.swift
//  Protecfer
//  Created by cyrine on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class LastProductsViewController: UIViewController {
    
    @IBOutlet weak var lastProductsCollectionView: UICollectionView!
    var wishlistRepository = WishlistRepository()

    var lastProducts = [Product]()
    var productRepository = ProductRepository()
    
    struct STORYBOARD {
       static let LAST_PRODUCTS_CELL = "lastProductTableViewCell"
       static let ADD_ORDER = "AddOrder"
       static let ADD_ORDER_POP_CONTROLLER = "AddOrderPopUpViewController"
       static let DETAIL_PRODUCT = "DetailProduct"
    }

    let cellScaling: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        productRepository.getLastProducts { (response) in
            self.lastProducts = response
            self.lastProductsCollectionView.reloadData()
        }
    }

}


extension LastProductsViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lastProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORYBOARD.LAST_PRODUCTS_CELL, for: indexPath) as! LastProductTableViewCell
        cell.product = lastProducts[indexPath.item]
        cell.delegate = self
        return cell
    }
}




extension LastProductsViewController : didOpenDetails {
    
    func addToOrder(item: Product) {
        if TOKEN.getTOKEN() == "-1" {
            self.showAlert()
        }else {
            let storyboard = UIStoryboard(name: STORYBOARD.ADD_ORDER , bundle: nil)
            let addOrderViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARD.ADD_ORDER_POP_CONTROLLER) as! AddOrderPopUpViewController
            addOrderViewController.currentProduct = item
            self.navigationController?.pushViewController(addOrderViewController, animated: true)
        }
    }
    
    func openDetail(item: Product) {
        let storyboard = UIStoryboard(name: STORYBOARD.DETAIL_PRODUCT, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController() as! DetailProductVC
        myVC.idProduct = item._id!
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    func showAlert() {
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
        if TOKEN.getTOKEN() == "-1"{
            self.showAlert()
        } else {
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
}


