//
//  UIKitExtension.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setTempId(_ id: String, key: String = "tempId"){
        UserDefaults.standard.set(id, forKey: key)
    }
    
    func getTempId(_ key: String = "tempId") -> String{
        if let tempId = UserDefaults.standard.string(forKey: key) {
            return tempId
        }
        
        return ""
    }
}
