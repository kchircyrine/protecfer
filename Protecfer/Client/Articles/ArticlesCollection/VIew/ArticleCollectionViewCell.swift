//
//  ArticleCollectionViewCell.swift
//  Protecfer
//
//  Created by cyrine on 08/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol didSomeActionFromCollection {
    func didOpenDetail(product : Product)
    func didAddToWishList(reference : String)
    func openArticlePopupView(product:Product)
}

class ArticleCollectionViewCell: UICollectionViewCell {
    
    var delegate : didSomeActionFromCollection!
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articlePrice: UILabel!
    
    var product : Product? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI () {
        let urlString = APPURL.PRODUCT_PICTURE_URL + (product?._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!)
        {
         articleImageView.image = UIImage(data: data)
        }
        articleTitle.text = product?.name
        articlePrice.text = "\(product?.price! ?? 0) DTN "
    }
    
    @IBAction func openDetailsAction(_ sender: Any) {
        self.delegate.didOpenDetail(product: self.product!)
    }
    
    
    @IBAction func wishListAction(_ sender: Any) {
        self.delegate.didAddToWishList(reference: (self.product?.reference!)!)
    }
    
    @IBAction func orderPopUpViewAction(_ sender: Any) {
        delegate?.openArticlePopupView( product: product!)
    }
    
    
}
