//  OrderlineCell.swift
//  Protecfer
//  Created by cyrine on 12/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol OrderLineCellDelegate : class {
    func orderLineCellDidTapTrash(_ sender: OrderlineCell)
}
class OrderlineCell: UITableViewCell {

    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productMesuredLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productReferenceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    weak var delegate: OrderLineCellDelegate?

    
    @IBAction func removeButtonAction(_ sender: Any) {
         delegate?.orderLineCellDidTapTrash(self)
    }
    
    var orderline: Orderline! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        productNameLabel?.text = orderline.product.name
        productReferenceLabel?.text = orderline.product.reference
        productPriceLabel?.text = "\(orderline.product.price!)"
        productQuantityLabel?.text = "\(orderline.quantity)"
        productMesuredLabel?.text = "larg: \(orderline.width) m - long: \(orderline.height) m -epai \(orderline.thickness) m"
        
        let urlString = APPURL.PRODUCT_PICTURE_URL + (orderline.product._id)! + "/-1"
        let url = URL(string:urlString)
        if let data = try? Data(contentsOf: url!)
        {
            productImageView.image = UIImage(data: data)
        }
    }
    
}
