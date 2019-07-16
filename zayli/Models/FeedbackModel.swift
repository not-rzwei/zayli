//
//  FeedbackModel.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

class Feedback: Object {
    // MARK: - Fields
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var idea = ""
    @objc dynamic var understanding = ""
    @objc dynamic var opinion = ""
    @objc dynamic var emotion = ""
    @objc dynamic var timestamp = NSDate().timeIntervalSince1970
    
    // MARK: - Relation mapping
    let record = LinkingObjects(fromType: Record.self, property: "feedbacks")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
