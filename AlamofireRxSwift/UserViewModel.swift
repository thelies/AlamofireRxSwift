//
//  UserViewModel.swift
//  AlamofireRxSwift
//
//  Created by le-ngoc-hoan on 2/1/17.
//  Copyright © 2017 Le Ngoc Hoan. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

class UserViewModel {
    let users: Observable<Results<User>>
    init() {
        let realm = try! Realm()
        let userObjs = realm.objects(User.self)
        users = Observable.from(userObjs)
    }
    
    let disposeBag = DisposeBag()
    
    func fetchUsers() {
        let result = APIService.sharedInstance.fetchUsers()
        result.subscribe(
            onNext: { result in
                switch result {
                case .success:
                    print("FetchUsers Success")
                case .error:
                    print("FetchUsers Error")
                }
            }
        )
        .addDisposableTo(disposeBag)
    }
    
    func fetchUserById(id: Int) {
        let result = APIService.sharedInstance.fetchUserById(id: id)
        result.subscribe(
            onNext: { result in
                switch result {
                case .success:
                    print("FetchUserById Success")
                case .error:
                    print("FetchUserById Error")
                }
        }
            )
            .addDisposableTo(disposeBag)
    }
}
