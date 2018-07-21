//
//  NouveauWishListViewController.swift
//  Protecfer
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import PusherSwift

class NouveauWishListViewController: UIViewController, SwiftyTableViewCellDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var wishListArray : [Wishlist] = [Wishlist]()
    var wishlistRepository = WishlistRepository()
    
    struct STORYBOARD {
        static let ADD_ORDER = "AddOrder"
    }
    
     static let PRODUCT_DETAIL_CELL = "ProductDetailCell"

    @IBOutlet weak var emptyMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillContent()
    }
    
 
    func openArticlePopupView(_ sender: WishlistTableViewCell, product: Product) {
        guard let tappedIndexPath =  tableView.indexPath(for: sender) else { return }
        let storyboard = UIStoryboard(name: STORYBOARD.ADD_ORDER, bundle: nil)
        let addOrderViewController = storyboard.instantiateInitialViewController() as! AddOrderPopUpViewController
        addOrderViewController.currentProduct = wishListArray[tappedIndexPath.row].product!
        self.navigationController?.pushViewController(addOrderViewController, animated: true)
    }
    
    func swiftyTableViewCellDidTapTrash(_ sender: WishlistTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
         // Delete the row
        wishlistRepository.removeFromWishlist(id: wishListArray[tappedIndexPath.row]._id){ success in
            if success {
                self.wishListArray.remove(at: tappedIndexPath.row)
                self.tableView.deleteRows(at: [tappedIndexPath], with: .automatic)
            } else {
                print("not successful")
            }
        }
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fillContent() {
        do {
                wishlistRepository.getWishlist { (response) in
                    self.wishListArray = response
                    if self.wishListArray.count == 0{
                        self.emptyMessage.isHidden = false
                        self.tableView.isHidden = true
                    }else{
                        self.emptyMessage.isHidden = true
                        self.tableView.isHidden = false
                    }
                    self.tableView.reloadData()
                }
        }
        
      
       let channel = AppPusher.pusher.subscribe("events-channel")
       channel.bind(eventName: "wishlists", callback: { (data: Any?) -> Void in
            if data != nil {
                do {
                    let test = data as! NSArray
                    self.wishListArray = [Wishlist]()
                    for item in test {
                        if let data = item as? NSDictionary {
                           let wishlist = Wishlist()
                            wishlist.parseWishlist(wishlistParse: data)
                           self.wishListArray.append(wishlist)
                            if self.wishListArray.count == 0{
                                self.emptyMessage.isHidden = false
                                self.tableView.isHidden = true
                            }else{
                                self.emptyMessage.isHidden = true
                                self.tableView.isHidden = false
                            }
                       }
                    }
                    self.tableView.reloadData()
                }

           }} )
      AppPusher.pusher.connect()
        
    }
    

}

extension NouveauWishListViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WishlistTableViewCell = tableView.dequeueReusableCell(withIdentifier: NouveauWishListViewController.PRODUCT_DETAIL_CELL) as! WishlistTableViewCell
        cell.product = self.wishListArray[indexPath.row].product
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}
