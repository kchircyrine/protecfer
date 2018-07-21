//
//  DescriptionTableViewCell.swift
//  Protecfer
//  Created by cyrine on 06/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    var product: Product! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI()
    {
      descriptionTextView.text = product.description
    }
   

   

}
