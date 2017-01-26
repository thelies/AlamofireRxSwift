//
//  UserModel.swift
//  AlamofireRxSwift
//
//  Created by le-ngoc-hoan on 1/26/17.
//  Copyright © 2017 Le Ngoc Hoan. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

struct User {
    let id: Int
    let name: String
    let url: String
    let avatarUrl: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["login"].stringValue
        self.url = json["url"].stringValue
        self.avatarUrl = json["avatar_url"].stringValue
    }
}
