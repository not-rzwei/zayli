//
//  PracticeDetailViewController.swift
//  zayli
//
//  Created by rshier on 20/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class PracticeDetailViewController: FormViewController {

    private var practice: Practice!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupTable()
    }
    
    func setupData(){
        let id = getTempId()
        practice = Realm.shared.object(ofType: Practice.self, forPrimaryKey: id)
    }
    
    func setupTable(){
        form
        
        +++ Section("idea")
        <<< LabelRow(){ row in
            row.title = practice.idea
        }
            
        +++ Section("background problem")
        <<< LabelRow(){ row in
            row.title = practice.background
        }
        
        +++ Section("specific problems"){ section in
            self.practice.problems.forEach { problem in
                section <<< LabelRow(){ row in
                    row.title = problem.name
                }
            }
        }
        
        +++ Section("solutions"){ section in
            self.practice.solutions.forEach { solution in
                section <<< LabelRow(){ row in
                    row.title = solution.name
                }
            }
        }
        
        +++ Section("target")
            <<< LabelRow(){ row in
                row.title = practice.target
        }
        
        +++ Section("summary")
            <<< TextAreaRow(){ row in
                row.value = practice.summary
        }
        
    }

}
