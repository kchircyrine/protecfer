//
//  CommentTableViewCell.swift
//  Protecfer
//
//  Created by Zouari on 02/05/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    var productComments = [Comment]()
    var viewController: UIViewController?
    
    struct Storyboard {
        static let commentCell = "CommentProductCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
  
}

extension CommentTableViewCell: UITableViewDelegate, UITableViewDataSource
{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productComments.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.commentCell, for: indexPath)  as! ProductCommentsTableViewCell
        cell.coment = self.productComments[indexPath.row]
        return cell
    }
    
    
    
    
    /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }*/
}
