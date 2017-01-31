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
    
    func getUsers() -> Observable<[User]> {
        let url = "\(baseUrl)/users"
        return request(url: url, method: .get).map { responseJson -> [User] in
            return responseJson.map {User(json: $0.1)}
        }
    }
}
