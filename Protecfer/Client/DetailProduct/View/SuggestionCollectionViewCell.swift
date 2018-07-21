//
//  SuggestionCollectionViewCell.swift
//  Protecfer
//  Created by cyrine on 02/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol didOpenAimableProduct {
    func didOpenAimable(item : Product)
    func addToWishList(reference: String)
    func openArticlePopupView(product:Product)
}

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    var delegate : didOpenAimableProduct!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    var product: Product! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        productTitleLabel.text = product.name
        productPriceLabel.text = "\(product.price!) DTN"
        let urlString = APPURL.PRODUCT_PICTURE_URL + (product?._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!) {
        self.imageView.image = UIImage(data: data)
        }
        //self.imageView.setNeedsLayout()
    }
    

    @IBAction func openDetailAction(_ sender: Any) {
        self.delegate.didOpenAimable(item: self.product)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        self.delegate.addToWishList(reference: self.product.reference!)
    }
    
    
    @IBAction func openOrderAction(_ sender: Any) {
        self.delegate.openArticlePopupView(product: self.product)
    }
    
    
}
