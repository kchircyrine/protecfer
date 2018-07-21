//
//  ArticlesCollectionsViewController.swift
//  Protecfer
//
//  Created by Zouari on 03/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class ArticlesCollectionsViewController: UIViewController {
    var wishlistRepository = WishlistRepository()

    //fix cell
    private let leftAndRightPaddings: CGFloat = 0.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    private let heightAdjustment: CGFloat = 100.0
    
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    var productRepository = ProductRepository()
    var productArray = [Product]()
    
     private let reuseIdentifierCellCollection = "articleCollection"
    
    struct STORYBOARD {
        static let DETAIL_PRODUCT  = "DetailProduct"
        static let ADD_ORDER = "AddOrder"
        static let LOGIN = "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesCollectionView.reloadData()
    }

}

extension ArticlesCollectionsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, didSomeActionFromCollection {
   
    func didOpenDetail(product: Product) {
        let storyboard = UIStoryboard(name: STORYBOARD.DETAIL_PRODUCT, bundle: nil)
        let myVC = storyboard.instantiateInitialViewController() as! DetailProductVC
        myVC.idProduct = product._id!
        self.navigationController?.pushViewController(myVC, animated: true)
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
    
    func didAddToWishList(reference: String) {
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellCollection, for: indexPath) as! ArticleCollectionViewCell
        cell.product = self.productArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    
 
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = (self.view.frame.width/2) - 10
        return CGSize(width: width,height: 200)
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
  
    
}
