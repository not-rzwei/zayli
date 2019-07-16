//
//  ProblemModel.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

class Problem: Object {
    // MARK: - Fields
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    
    // MARK: - Relation mapping
    let practice = LinkingObjects(fromType: Practice.self, property: "problems")
}
