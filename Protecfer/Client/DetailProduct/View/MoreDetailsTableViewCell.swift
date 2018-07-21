//  MoreDetailsTableViewCell.swift
//  Protecfer
//  Created by cyrine on 10/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class MoreDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var productColorsLabel: UILabel!
    @IBOutlet weak var productReferenceLabel: UILabel!
    
    var product: Product! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        productColorsLabel.text = product.colors
        productReferenceLabel.text = product.reference
    }
    

}



