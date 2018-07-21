//
//  HomeViewController.swift
//  Protecfer
//  Created by cyrine kchir on 15/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {

    @IBOutlet weak var presentationCollectionView: UICollectionView!
    
    var presentations = Presentation.fetchInterests()
    let cellScaling: CGFloat = 0.8
    
    struct STORYBOARD {
       static let PRESENTATION = "PresentationCollectionViewCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScaling)
//        let cellHeight = floor(screenSize.height * cellScaling)
//        
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//        
//        let layout = presentationCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        presentationCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
//        
        presentationCollectionView?.dataSource = self
        presentationCollectionView?.delegate = self
        
        
       
    }
}

extension PresentationViewController : UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORYBOARD.PRESENTATION , for: indexPath) as! PresentationCollectionViewCell
        cell.presentation = presentations[indexPath.item]
        return cell
    }
}



