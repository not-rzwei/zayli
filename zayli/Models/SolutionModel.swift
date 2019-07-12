//
//  SolutionModel.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

class Solution: Object {
    @objc dynamic var name = ""
    let practice = LinkingObjects(fromType: Practice.self, property: "solutions")
}
