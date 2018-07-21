//
//  SubmitOrderTableViewCell.swift
//  Protecfer
//  Created by cyrine on 13/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

protocol SubmitOrderTableViewCellDelegate : class {
    func submitOrderCellDidTapValidate(_ sender: SubmitOrderTableViewCell)
}
class SubmitOrderTableViewCell: UITableViewCell {

    weak var delegate: SubmitOrderTableViewCellDelegate?
    
    @IBAction func submitOrderButtonAction(_ sender: Any) {
        delegate?.submitOrderCellDidTapValidate(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
