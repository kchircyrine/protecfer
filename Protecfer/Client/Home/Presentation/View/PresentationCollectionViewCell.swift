//
//  PresentationCollectionViewCell.swift
//  Protecfer
//  Created by cyrine kchir on 15/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit



class PresentationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var presentationImageView: UIImageView!
    @IBOutlet weak var presentationTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var presentation: Presentation? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let presentation = presentation {
            presentationImageView.image = presentation.featuredImage
            presentationTitleLabel.text = presentation.title
            backgroundColorView.backgroundColor = presentation.color
        } else {
            presentationImageView.image = nil
            presentationTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
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
    
}
