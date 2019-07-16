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

extension Realm {
    static let shared = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    static func wipeOut(){
        autoreleasepool {
            // all Realm usage here
        }
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }
    }
}
