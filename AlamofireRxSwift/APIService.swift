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
    
    static let sharedInstance = APIService()
    
    func request(url: String) -> Observable<JSON> {
        return Observable.create{ observer in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            Alamofire.request(url)
                .validate(statusCode: 200..<300)
                .responseJSON { responseData in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if responseData.result.value != nil {
                        observer.onNext(JSON(responseData.result.value ?? ""))
                        observer.onCompleted()
                    } else {
                        observer.onError(responseData.result.error!)
                    }
                }
            return Disposables.create()
        }
    }
    
    func getUsers() -> Observable<[User]> {
        let url = "https://api.github.com/users"
        return request(url: url).map { responseJson -> [User] in
            return responseJson.map {User(json: $0.1)}
        }
    }
}
