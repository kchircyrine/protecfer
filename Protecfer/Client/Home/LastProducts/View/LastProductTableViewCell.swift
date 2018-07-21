//
//  LastProductTableViewCell.swift
//  Protecfer
//  Created by cyrine on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol didOpenDetails {
    func addToWishList(reference: String)
    func openDetail(item: Product)
    func addToOrder(item: Product)
}

class LastProductTableViewCell: UICollectionViewCell {
    
    var delegate : didOpenDetails!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let product = product {
            let urlString = APPURL.PRODUCT_PICTURE_URL + (product._id)! + "/-1"
            let url = URL(string:urlString)
            if let data = try? Data(contentsOf: url!)
            {
                productImageView.image = UIImage(data: data)
            }
            productTitleLabel.text = product.name
           productPriceLabel.text = "\(product.price!) DTN"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
    
    
    @IBAction func openDetailAction(_ sender: Any) {
        self.delegate.openDetail(item: self.product!)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        self.delegate.addToWishList(reference: (self.product?.reference!)!)
    }
    
    @IBAction func cartButtonAction(_ sender: Any) {
        self.delegate.addToOrder(item: product!)
    }
    
    
    
    
    
}
