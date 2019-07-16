//
//  NewPracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class NewPracticeViewController: FormViewController {
    
    // MARK: - Form Outlet
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        let problems = form.getMultivaluedSection("problems") as! Array<String>
        let solutions = form.getMultivaluedSection("solutions") as! Array<String>
        
        let practice = Practice()

        practice.idea = form.valueByTag("idea")
        practice.background = form.valueByTag("background")
        practice.target = form.valueByTag("target")
        practice.summary = form.valueByTag("summary")

        problems.forEach { problem in
            let obj = Problem()
            obj.name = problem
            practice.problems.append(obj)
        }

        solutions.forEach { solution in
            let obj = Solution()
            obj.name = solution
            practice.solutions.append(obj)
        }

        practice.write()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForm()
    }
    
    func setupForm() {
        
        var rules = RuleSet<String>()
        rules.add(rule: RuleRequired())
        rules.add(rule: RuleMinLength(minLength: 5))
        
        tableView.isEditing = true
        
        form
        +++ Section("idea")
        <<< TextRow("idea"){ row in
            row.placeholder = "Input your idea"
        }
            
        +++ Section("background problem")
        <<< TextRow("background"){ row in
            row.placeholder = "The big problem"
        }

        +++ MultivaluedSection(
                multivaluedOptions: [.Insert, .Delete],
                header: "specific Problems") {
            $0.tag = "problems"
                    
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add specific problem"
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
            
        +++ Section("target user")
        <<< TextRow("target"){ row in
            row.placeholder = "For whom?"
        }
        
        +++ Section("summary")
        <<< TextAreaRow("summary"){ row in
            row.placeholder = "Write your idea's summary"
        }
        
        
    }

}
