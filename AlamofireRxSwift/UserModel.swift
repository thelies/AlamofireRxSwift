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
import RealmSwift

class User: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var url = ""
    dynamic var avatarUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["login"].stringValue
        self.url = json["url"].stringValue
        self.avatarUrl = json["avatar_url"].stringValue
    }
}
