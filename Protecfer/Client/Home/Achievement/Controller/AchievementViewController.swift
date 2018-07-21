//
//  AchievementViewController.swift
//  Protecfer
//  Created by cyrine kchir on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {
    
    @IBOutlet weak var achievementsCollectionView: UICollectionView!
    var achievementRepository = AchievementRepository()
    var achievements = [Achievement]()
    
    struct STORYBOARD {
        static let ACHIEVEMENT = "achievementViewController"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        achievementRepository.getActiveAchievements { (response) in
            self.achievements = response
            self.achievementsCollectionView.reloadData()
        }
    }

}

extension AchievementViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORYBOARD.ACHIEVEMENT, for: indexPath) as! AchievementCollectionViewCell
          cell.achievement = achievements[indexPath.item]
        return cell
    }
}

