//
//  PracticeModel.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

class Practice: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var timestamp  = NSDate().timeIntervalSince1970
    @objc dynamic var idea = ""
    @objc dynamic var target = ""
    @objc dynamic var summary = ""
    @objc dynamic var background = ""
    let problems = List<Problem>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
