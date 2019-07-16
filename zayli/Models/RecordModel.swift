//
//  RecordModel.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object {
    // MARK: - Fields
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var resource = ""
    @objc dynamic var timestamp = NSDate().timeIntervalSince1970
    
    // MARK: - Relation mapping
    let practice = LinkingObjects(fromType: Practice.self, property: "records")
    let feedbacks = List<Feedback>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
