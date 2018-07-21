//
//  WishlistTableViewCell.swift
//  Protecfer
//  Created by Zouari on 21/07/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit


protocol SwiftyTableViewCellDelegate : class {
    func openArticlePopupView(_ sender: WishlistTableViewCell, product:Product)
    func swiftyTableViewCellDidTapTrash(_ sender: WishlistTableViewCell)
}

class WishlistTableViewCell: UITableViewCell {

        @IBOutlet weak var productNameLabel: UILabel!
        @IBOutlet weak var productReferenceLabel: UILabel!
        @IBOutlet weak var productPriceLabel: UILabel!
        @IBOutlet weak var productImageView: UIImageView!
        
        
        weak var delegate: SwiftyTableViewCellDelegate?
        
        @IBAction func trashTapped(_ sender: UIButton) {
            delegate?.swiftyTableViewCellDidTapTrash(self)
        }
        
        
        @IBOutlet weak var trashButton: UIButton!
        
        var product: Product! {
            didSet {
                self.updateUI()
            }
        }
        
        
        @IBAction func addToOrderAction(_ sender: Any) {
            delegate?.openArticlePopupView(self, product: product)
        }
        
        func updateUI()
        {
            productNameLabel?.text = product?.name
            productReferenceLabel?.text = product?.reference
            productPriceLabel.text = "\(product.price!) TND"
            let urlString = APPURL.PRODUCT_PICTURE_URL + (product?._id)! + "/-1"
            
            //let urlString = APPURL.PRODUCT_PICTURE_URL + "5ae6b9e4a7b46105255245ca/-1"
            let url = URL(string:urlString)
            if let data = try? Data(contentsOf: url!)
            {
                productImageView.image = UIImage(data: data)
            }
        }
        
        
    }


