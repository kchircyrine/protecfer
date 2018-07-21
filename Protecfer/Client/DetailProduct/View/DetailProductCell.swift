//  DetailProductCell.swift
//  Protecfer
//  Created by cyrine on 10/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class DetailProductCell: UITableViewCell {

 
    //@IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productNameLabel: UILabel!
  

   var product: Product! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI()
    {
        productNameLabel.text = product.name
       // let size = self.productDescriptionTextView.contentSize;
       // self.heightConstraint.constant = size.height;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


    

