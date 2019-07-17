//
//  NewFeedbackViewController.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import Eureka

class NewFeedbackViewController: FormViewController {
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupForm()
    }
    
    func setupForm(){
        tableView.isEditing = true
        
        form
            +++ Section("name")
            <<< TextRow("name"){ row in
                row.placeholder = "What is your name?"
            }
            
            +++ Section("idea")
            <<< TextRow("idea"){ row in
                row.placeholder = "What idea have you get?"
            }
            
            +++ Section("understanding")
            <<< TextAreaRow("understanding"){ row in
                row.placeholder = "Your understanding about the idea"
            }
                    
            +++ Section("opinion")
            <<< TextAreaRow("opinion"){ row in
                row.placeholder = "Your opinion about story delivering"
            }
                    
            +++ Section("emotion")
            <<< TextRow("emotion"){ row in
                row.placeholder = "What kind of emotion do you feel?"
            }
        
        }
    
}
