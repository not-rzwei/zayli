//
//  FeedbackDetailViewController.swift
//  zayli
//
//  Created by rshier on 19/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift

class FeedbackDetailViewController: UIViewController {

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
    }

}
