//
//  FeedbackDetailViewController.swift
//  zayli
//
//  Created by rshier on 19/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift
import Eureka

class FeedbackDetailViewController: FormViewController {

    private var feedback: Feedback!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupUI()
        
    }
    
    func setupData(){
        let id = getTempId("feedbackId")
        feedback = Realm.shared.object(ofType: Feedback.self, forPrimaryKey: id)
    }
    
    func setupUI(){
        title = "From " + feedback.name
        
        form
        +++ Section("Name")
        <<< LabelRow(){ row in
            row.title = feedback.name
        }
            
        +++ Section("emotion")
        <<< LabelRow(){ row in
            row.title = feedback.emotion
        }
            
        +++ Section("Understanding")
        <<< TextAreaRow(){ row in
                row.value = feedback.understanding
        }
        
        +++ Section("story delivering")
        <<< TextAreaRow(){ row in
            row.value = feedback.opinion
        }
    }

}
