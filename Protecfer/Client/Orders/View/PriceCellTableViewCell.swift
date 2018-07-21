//
//  PriceCellTableViewCell.swift
//  Protecfer
//  Created by cyrine on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class PriceCellTableViewCell: UITableViewCell {

    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
