//
//  AimableProductViewController.swift
//  Protecfer
//
//  Created by cyrine on 10/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class AimableProductViewController: UIViewController {
    var wishlistRepository = WishlistRepository()

    weak var detailVC : DetailProductVC!
    
    @IBOutlet weak var collectionView: UICollectionView!
     var aimableProductArray = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AimableProductViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aimableProductArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SuggestionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCollectionViewCell
        cell.product = self.aimableProductArray[indexPath.row]
        cell.delegate = self
        return cell
    }
    

}

extension AimableProductViewController: didOpenAimableProduct{
    
    
    func openArticlePopupView(product: Product) {
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
        } else {
            let storyboard = UIStoryboard(name: "AddOrder", bundle: nil)
            let addOrderViewController = storyboard.instantiateViewController(withIdentifier: "AddOrderPopUpViewController") as! AddOrderPopUpViewController
            addOrderViewController.currentProduct = product
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
    
    func didOpenAimable(item: Product) {
        self.detailVC.idProduct = item._id!
         self.detailVC.loadContent()
    }
    
    
    func addToWishList(reference: String) {
        
        if TOKEN.getTOKEN() == "-1"{
            self.showLogin()
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
