//
//  NewPracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import Eureka

class NewPracticeViewController: FormViewController {
    
    // MARK: - Form Outlet
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        setupForm()
    }
    
    func setupForm() {
        form
        +++ Section("idea")
        <<< TextRow("idea"){ row in
            row.placeholder = "Input your idea"
        }
        
        +++ Section("problem")
            <<< TextRow("problem"){ row in
                row.placeholder = "Specify your problem"
        }
        
        +++ Section("solution")
            <<< TextRow("solution"){ row in
                row.placeholder = "Propose your solution"
        }
        
        +++ Section("summary")
            <<< TextAreaRow("summary"){ row in
                row.placeholder = "Write your idea's summary"
        }
    }

}
