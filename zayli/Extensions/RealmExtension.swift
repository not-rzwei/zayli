//
//  RealmExtension.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    func write(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(self)
        }
    }
    
    func writeAsync(){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                self.write()
            }
        }

    }
}
