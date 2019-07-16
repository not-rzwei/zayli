//
//  RecordingViewController.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift

class RecordingViewController: UITableViewController {
    
    private var practice: Practice?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
    }
    
    func setupData(){
        let id = getTempId()
        
        practice = Realm.shared.object(ofType: Practice.self, forPrimaryKey: id)
    }
    
    func setupUI(){
        title = practice?.idea
    }
    
}
