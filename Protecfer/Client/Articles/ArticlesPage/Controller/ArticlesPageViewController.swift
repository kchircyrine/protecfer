//
//  ArticlesPageViewController.swift
//  Protecfer
//  Created by cyrine on 03/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Alamofire
class ArticlesPageViewController: UIViewController {
    var sourceNavigation : Bool = false
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gridBtn: UIButton!
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var searchBarTextView: UITextField!
    @IBOutlet weak var listViewContainer: UIView!
    @IBOutlet weak var collectionViewContainer: UIView!
    
    var productSavedArray = [Product]()
    var productFilteredArray = [Product]()
    var type: Type!
    
    weak var listArticles : ListArticlesTableViewController!
    weak var collectionArticles : ArticlesCollectionsViewController!
    
    
    struct IDENTIFIERS {
        static let ARTICLES_COLLECTION  = "articlesCollection"
        static let ARTICLES_LIST = "ListArticles"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBarTextView.delegate = self
        self.searchBarTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.gridBtn.isHidden = false
        self.listBtn.isHidden = true
        
        self.loadContentOfArrays()
        
        // Do any additional setup after loading the view.
        self.checkBackAvailability()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.type != nil ) {
            self.searchBarTextView.text = self.type.name
            self.filterContentArrays(searching: self.type._id)
        }
    }

    
    func checkBackAvailability() {
        if sourceNavigation{
            self.backButton.isHidden = false
            self.topConstraint.constant = 50
        }else{
            self.backButton.isHidden = true
            self.topConstraint.constant = 20
        }
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.loadContentOfArrays()
        if segue.identifier == IDENTIFIERS.ARTICLES_COLLECTION {
            self.collectionArticles = segue.destination as! ArticlesCollectionsViewController
            }
        
        if segue.identifier == IDENTIFIERS.ARTICLES_LIST {
            self.listArticles = segue.destination as! ListArticlesTableViewController
           }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func showListAction(_ sender: Any) {
         self.gridBtn.isHidden = false
        self.listBtn.isHidden = true
        self.listViewContainer.alpha = 1
        self.collectionViewContainer?.alpha = 0
    }
    
    
    @IBAction func showGridAction(_ sender: Any) {
        self.gridBtn.isHidden = true
        self.listBtn.isHidden = false
        self.listViewContainer.alpha = 0
        self.collectionViewContainer?.alpha = 1
    }
    
    
    func loadContentOfArrays() {
        Alamofire.request(APPURL.PRODUCT_URL).responseJSON { response in
            let result = response.data
            do {
                self.productSavedArray.removeAll()
                self.productSavedArray = try JSONDecoder().decode([Product].self, from: result!)
                self.collectionArticles.productArray.removeAll()
                self.collectionArticles.productArray = self.productSavedArray
                self.collectionArticles.articlesCollectionView.reloadData()
                
                self.listArticles.productArray.removeAll()
                self.listArticles.productArray = self.productSavedArray
                self.listArticles.articlesTableView.reloadData()
                 }
            catch {
                print("error")
            }
        }
        let channel = AppPusher.pusher.subscribe("events-channel")
        channel.bind(eventName: "products", callback: { (data: Any?) -> Void in
            if data != nil {
                do {
                    let test = data as! NSArray
                    self.productSavedArray = [Product]()
                    for item in test {
                        if let data = item as? NSDictionary {
                            let product = Product()
                            product.parseProduct(productDictionnary: data)
                            self.productSavedArray.append(product)
                        }
                    }
                    self.collectionArticles.productArray.removeAll()
                    self.collectionArticles.productArray = self.productSavedArray
                    self.collectionArticles.articlesCollectionView.reloadData()
                    
                    
                    self.listArticles.productArray.removeAll()
                    self.listArticles.productArray = self.productSavedArray
                    self.listArticles.articlesTableView.reloadData()
                }
                
            }} )
        AppPusher.pusher.connect()
    }
    
    func removeAll () {
        self.listArticles.productArray.removeAll()
        self.collectionArticles.productArray.removeAll()
        self.productFilteredArray.removeAll()
    }
    
    func filterContentArrays(searching : String)  {
        
        if searching == "" {
            self.removeAll()
            self.productFilteredArray = self.productSavedArray
            self.listArticles.productArray = self.productFilteredArray
            self.listArticles.articlesTableView.reloadData()
            self.collectionArticles.productArray = self.productFilteredArray
            self.collectionArticles.articlesCollectionView.reloadData()
        } else {
            self.removeAll()
            self.productFilteredArray =
                 self.productSavedArray.filter({ $0.name?.lowercased().contains(searching.lowercased()) == true || $0.type?.lowercased().contains(searching.lowercased()) == true || $0.category?.name!.lowercased().contains(searching.lowercased()) == true})
            
            self.listArticles.productArray = self.productFilteredArray
            self.listArticles.articlesTableView.reloadData()
            self.collectionArticles.productArray = self.productFilteredArray
            self.collectionArticles.articlesCollectionView.reloadData()
        }
    }
    
}

extension ArticlesPageViewController : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.filterContentArrays(searching: textField.text!)
    }
}
