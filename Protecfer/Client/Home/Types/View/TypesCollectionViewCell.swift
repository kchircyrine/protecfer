//  CategoriesCollectionViewCell.swift
//  Protecfer
//  Created by cyrine on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class TypesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeTitleLabel: UILabel!
    
    
    var type: Type? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let type = type {
            let urlString = APPURL.PICTURE_TYPES_URL + (type._id)
            let url = URL(string:urlString)
            if let data = try? Data(contentsOf: url!)
            {
                typeImageView.image = UIImage(data: data)
            }
            typeTitleLabel.text = type.name
        } else {
            typeImageView.image = nil
            typeTitleLabel.text = nil
        }
    }
    
}
