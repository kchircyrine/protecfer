//
//  SuggestionTableViewCell.swift
//  Protecfer
//  Created by cyrine on 02/02/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    var similarProducts = [Product]()
    var viewController: UIViewController?
   
    
    struct Storyboard {
        static let SUGGESTION_CELL = "SuggestionCell"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.delegate = self
        suggestionCollectionView.isScrollEnabled = false
    }
    
}

extension SuggestionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.SUGGESTION_CELL, for: indexPath) as! SuggestionCollectionViewCell
        cell.product = similarProducts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        let myVC = viewController?.storyboard?.instantiateInitialViewController() as! DetailProductVC
        myVC.currentProduct = similarProducts[indexPath.row]
        myVC.tableView.reloadData()
        //viewController?.present(myVC, animated: true, completion: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewController = nil
    }
    
    
    
    
    
    
}
