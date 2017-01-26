//
//  ViewController.swift
//  AlamofireRxSwift
//
//  Created by le-ngoc-hoan on 1/26/17.
//  Copyright © 2017 Le Ngoc Hoan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var users: [User]?
    let url = "https://api.github.com/users"
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.doRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doRefresh() {
        print("Do Refresh")
        getUsers()
        self.refreshControl.endRefreshing()
    }
    
    func getUsers() {
        let users = APIService.sharedInstance.getUsers()
        tableView.delegate = nil
        tableView.dataSource = nil
        users.bindTo(tableView.rx.items(cellIdentifier: UserCell.identifier, cellType: UserCell.self)) { (row, element, cell) in
            let avatarUrl = NSURL(string: element.avatarUrl)
            cell.avatarImage.sd_setImage(with: avatarUrl as URL!)
            cell.nameLabel.text = element.name
            cell.linkLabel.text = element.url
        }
        .addDisposableTo(disposeBag)
        
        tableView.reloadData()
    }
}

