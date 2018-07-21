//
//  CategoriesViewController.swift
//  Protecfer
//  Created by cyrine on 16/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class TypesViewController: UIViewController {
    
    var typeRepository = TypeRepository()
    var types = [Type]()
    
    struct STORYBOARD {
        static let ARTICLES_PAGE  = "ArticlesPage"
        static let ARTICLES_PAGE_CONTROLLER = "ArticlesPageViewController"
        static let TYPES_COLLECTION_CELL = "typesCollectionViewCell"
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        typeRepository.getTypes { (response) in
            self.types = response
            self.categoriesCollectionView.reloadData()
        }
    }
}

extension TypesViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORYBOARD.TYPES_COLLECTION_CELL, for: indexPath) as! TypesCollectionViewCell
        cell.type = types[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: STORYBOARD.ARTICLES_PAGE, bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier:STORYBOARD.ARTICLES_PAGE_CONTROLLER) as! ArticlesPageViewController
        myVC.sourceNavigation = true
        myVC.type = types[indexPath.row]
        self.navigationController?.show(myVC, sender: self)
    }
    
    
}
