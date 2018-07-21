//
//  ProductCommentsTableViewCell.swift
//  Protecfer
//
//  Created by cyrine on 02/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class ProductCommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var SeparatoView: UIView!
    
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    let format = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = Date()
    
    var coment: Comment! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        commentTitleLabel.text = (self.coment.user?.firstName)! + " " + (self.coment.user?.lastName)!
        commentDateLabel.text = "\(self.coment.creationDate!)"
        let date = self.coment.creationDate?.toDate(format: format) as Date?
        commentDateLabel.text = "\(date!.toString(format: "dd MMM yyyy HH:mm")!)"
        commentTextView.text = self.coment.text
    }
    
    
}
