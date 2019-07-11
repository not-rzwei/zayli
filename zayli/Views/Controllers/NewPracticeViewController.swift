//
//  NewPracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit

class NewPracticeViewController: UITableViewController {

    // MARK: - Form Outlets

    @IBOutlet weak var ideaInput: UITextField!
    @IBOutlet weak var problemInput: UITextField!
    @IBOutlet weak var solutionInput: UITextField!
    @IBOutlet weak var summaryInput: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
