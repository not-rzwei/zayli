//
//  Eureka.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import Eureka

extension Form {
    func getMultivaluedSection(_ key: String) -> Array<Any>{
        return (self.values()[key]!! as! [Any?]).compactMap { $0 }
    }
    
    func valueByTag(_ key: String) -> String {
        return self.values()[key] as! String
    }
}
