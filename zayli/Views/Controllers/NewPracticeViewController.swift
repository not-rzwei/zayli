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
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
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
    
    func formValidate(){
        var errorCount = 0
        
        form.allRows.flatMap { row in
            let error = row.validate()
            
            if !error.isEmpty {
                errorCount += 1
            }
        }
        
        if errorCount == 0 {
            doneButton.isEnabled = true
        }
    }
    
    func setupForm() {
        
        var rules = RuleSet<String>()
        rules.add(rule: RuleRequired())
        rules.add(rule: RuleMinLength(minLength: 5))
        
        tableView.isEditing = true
        doneButton.isEnabled = false
        
        
        form
        +++ Section("idea")
        <<< TextRow("idea"){ row in
            row.placeholder = "Beach Plastic Waste"
            
            row.add(ruleSet: rules)
            row.validationOptions = .validatesOnDemand
            
            row.onChange { _ in
                self.formValidate()
            }
        }
            
        +++ Section("background problem")
        <<< TextRow("background"){ row in
            row.placeholder = "Garbage piles up"
            
            row.add(ruleSet: rules)
            row.validationOptions = .validatesOnDemand
            
            row.onChange { _ in
                self.formValidate()
            }
        }

        +++ MultivaluedSection(
                multivaluedOptions: [.Insert, .Delete],
                header: "specific Problems",
                footer: "The small problems you encounter") {
            $0.tag = "problems"
                    
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add specific problem"
                }
            }
            
            $0.multivaluedRowToInsertAt = { index in
                return TextRow() {
                    $0.placeholder = "Damage to marine ecosystem"
                    
                    $0.add(ruleSet: rules)
                    $0.validationOptions = .validatesOnDemand
                    
                    $0.onChange { _ in
                        self.formValidate()
                    }
                }
            }
                    
            $0 <<< TextRow() {
                $0.placeholder = "Damage to marine ecosystem"
                
                $0.add(ruleSet: rules)
                $0.validationOptions = .validatesOnDemand
                
                $0.onChange { _ in
                    self.formValidate()
                }
            }
        }
            
        +++ MultivaluedSection(
            multivaluedOptions: [.Insert, .Delete],
            header: "Solutions",
            footer: "The solution for the problem") {
                $0.tag = "solutions"
                
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add solution"
                }
            }
            
            $0.multivaluedRowToInsertAt = { index in
                return TextRow() {
                    $0.placeholder = "Waste sorting"
                    
                    $0.add(ruleSet: rules)
                    $0.validationOptions = .validatesOnDemand
                    
                    $0.onChange { _ in
                        self.formValidate()
                    }
                }
            }
            
            $0 <<< TextRow() {
                $0.placeholder = "Waste sorting"
                
                $0.add(ruleSet: rules)
                $0.validationOptions = .validatesOnDemand
                
                $0.onChange { _ in
                    self.formValidate()
                }
            }
        }
            
        +++ Section("target user")
        <<< TextRow("target"){ row in
            row.placeholder = "Beach visitor"
            
            row.add(ruleSet: rules)
            row.validationOptions = .validatesOnDemand
            
            row.onChange { _ in
                self.formValidate()
            }
        }
        
        +++ Section("summary")
        <<< TextAreaRow("summary"){ row in
            row.placeholder = "Plastic has been found in more than 60% of all seabirds and ..."
            
            row.add(ruleSet: rules)
            row.validationOptions = .validatesOnDemand
            
            row.onChange { _ in
                self.formValidate()
            }
        }
        
        
    }

}
