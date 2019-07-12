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
        saveButton.isEnabled = false
        
        setupForm()
    }
    
    func setupForm() {
        form
        +++ Section("idea")
        <<< TextRow("idea"){ row in
            row.placeholder = "Input your idea"
        }

        +++ MultivaluedSection(
                multivaluedOptions: [.Insert, .Delete],
                header: "Problems") {
            $0.tag = "solutions"
                    
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add problem"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return TextRow() {
                    $0.placeholder = "Specify the problem"
                }
            }
        }
            
        +++ MultivaluedSection(
            multivaluedOptions: [.Insert, .Delete],
            header: "Solutions") {
                $0.tag = "solutions"
                
                $0.addButtonProvider = { section in
                    return ButtonRow(){
                        $0.title = "Add solution"
                    }
                }
                $0.multivaluedRowToInsertAt = { index in
                    return TextRow() {
                        $0.placeholder = "Propose your solution"
                    }
                }
                
        }
        
        
        +++ Section("summary")
        <<< TextAreaRow("summary"){ row in
            row.placeholder = "Write your idea's summary"
        }
    }

}
