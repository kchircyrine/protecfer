//
//  ArticleTableViewCell.swift
//  Protecfer
//
//  Created by cyrine kchir on 10/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol ArticleTableViewCellDelegate : class {
    func articleTableViewCellWishlist(_ sender: ArticleTableViewCell, productReference:String)
    func openArticlePopupView(product:Product)
    func didOpenDetail(product : Product)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var articlePriceLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
     weak var delegate: ArticleTableViewCellDelegate?
 
    var product : Product? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI () {
        let urlString = APPURL.PRODUCT_PICTURE_URL + (product?._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!) {
            articleImageView.image = UIImage(data: data)
        }
        articleTitleLabel.text = product?.name
        articlePriceLabel.text = " \(product!.price!) DTN"
         contentView.backgroundColor = UIColor(red: 240/255.0, green:  240/255.0, blue:  240/255.0, alpha: 1)
    }

    @IBAction func wishlistButtonAction(_ sender: Any) {
     delegate?.articleTableViewCellWishlist(self, productReference: (product?.reference)!)
    }
    
    @IBAction func openDetailAction(_ sender: Any) {
        self.delegate?.didOpenDetail(product: self.product!)
    }
    

    @IBAction func orderPopUpViewAction(_ sender: Any) {
        delegate?.openArticlePopupView( product: product!)
    }
}
