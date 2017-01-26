//
//  ViewController.swift
//  AlamofireRxSwift
//
//  Created by le-ngoc-hoan on 1/26/17.
//  Copyright © 2017 Le Ngoc Hoan. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var users: [User]?
    let url = "https://api.github.com/users"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.delegate = self
        // tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        let users = APIService.sharedInstance.getUsers()
        users.subscribe(
            onNext: { json in
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>")
                print(json)
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>")
            },
            onError: { error in
                print(error)
            },
            onCompleted: {
                print("Completed")
            },
            onDisposed: {
                print("Disposed")
            }
        )
        .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

