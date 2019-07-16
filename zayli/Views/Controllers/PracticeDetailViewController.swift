//
//  PracticeDetailViewController.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift

class PracticeDetailViewController: UITableViewController {
    // MARK: - Detail Outlets
    @IBOutlet weak var ideaLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    private var practice: Practice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        ideaLabel.text = practice?.idea
        backgroundLabel.text = practice?.background
        problemLabel.text = "\(practice!.problems.count) problem"
        solutionLabel.text = "\(practice!.solutions.count) solution"
        targetLabel.text = practice?.target
        summaryLabel.text = practice?.summary
        
        print(practice)
    }
    
    func populate(_ practice: Practice){
        self.practice = practice
    }
}
