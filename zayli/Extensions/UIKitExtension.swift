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

@IBDesignable
class MyPrettyDesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}

@IBDesignable
class MyPrettyDesignableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }

}
