//
//  AchievementCollectionViewCell.swift
//  Protecfer
//
//  Created by cyrine kchir on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class AchievementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var achievementImageView: UIImageView!
    @IBOutlet weak var achievementTitleLabel: UILabel!
    @IBOutlet weak var achievementAdressLabel: UILabel!
    
    var achievement: Achievement? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let achievement = achievement {
            let urlString = APPURL.ACHIEVEMENT_IMG_URL + (achievement._id)!
            let url = URL(string:urlString)
            if let data = try? Data(contentsOf: url!)
            {
                achievementImageView.image = UIImage(data: data)
            }
            achievementTitleLabel.text = achievement.title
            achievementAdressLabel.text = achievement.description
        }
        else {
            achievementImageView.image = nil
            achievementTitleLabel.text = nil
        }
    }
    
}
