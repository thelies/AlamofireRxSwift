//
//  APIService.swift
//  AlamofireRxSwift
//
//  Created by le-ngoc-hoan on 1/26/17.
//  Copyright © 2017 Le Ngoc Hoan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON
import RxRealm
import RealmSwift

enum RequestResult {
    case success
    case error
}

class APIService {
    
    let baseUrl = "https://api.github.com"
    
    static let sharedInstance = APIService()
    
    func request(url: String, method: HTTPMethod) -> Observable<JSON> {
        return Observable.create{ observer in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            Alamofire.request(url, method: method)
                .validate(statusCode: 200..<300)
                .responseJSON { responseData in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    switch responseData.result {
                    case .success(let value):
                        observer.onNext(JSON(value))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchUsers() -> Observable<RequestResult> {
        let url = "\(baseUrl)/users"
         return request(url: url, method: .get)
            .map { json -> RequestResult in
                let realm = try! Realm()
                try! realm.write {
                    for item in json {
                        let user = User(json: item.1)
                        realm.create(User.self, value: user, update: true)
                    }
                }
            return RequestResult.success
        }
    }
    
    func fetchUserById(id: Int) -> Observable<RequestResult> {
        let url = "\(baseUrl)/users/\(id)"
        return request(url: url, method: .get)
            .map { json -> RequestResult in
                let realm = try! Realm()
                try! realm.write {
                    let user = User(json: json)
                    realm.create(User.self, value: user, update: true)
                }
                return RequestResult.success
        }
    }
}
