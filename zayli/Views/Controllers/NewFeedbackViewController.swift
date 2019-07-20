//
//  NewFeedbackViewController.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift
import SwiftySound

class NewFeedbackViewController: FormViewController {
    
    @IBOutlet weak var playbackButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private var record: Record!
    private var playback: Sound!
    private var playbackState: audioState = .stopped {
        didSet {
            updatePlaybackState()
        }
    }
    
    enum audioState {
        case playing
        case stopped
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        let feedback = Feedback()
        
        feedback.name = form.valueByTag("name")
        feedback.idea = form.valueByTag("idea")
        feedback.understanding = form.valueByTag("understanding")
        feedback.opinion = form.valueByTag("opinion")
        feedback.emotion = form.valueByTag("emotion")
        
        try! Realm.shared.write {
            record?.feedbacks.append(feedback)
        }
        
        performSegue(withIdentifier: "GoFeedbackThanks", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupForm()
        setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Sound.stopAll()
    }
    
    func setupData(){
        let recordId = getTempId("recordId")
        record = Realm.shared.object(ofType: Record.self, forPrimaryKey: recordId)
        
        let playbackUrl = URL(string: record!.resource)!
        playback = Sound(url: playbackUrl)
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
    
    func setupForm(){
        tableView.isEditing = true
        doneButton.isEnabled = false
        
        var rules = RuleSet<String>()
        rules.add(rule: RuleRequired())
        rules.add(rule: RuleMinLength(minLength: 3))
        
        form
            +++ Section("name")
            <<< TextRow("name"){ row in
                row.placeholder = "What is your name?"
                
                row.add(ruleSet: rules)
                row.validationOptions = .validatesOnDemand
                
                row.onChange { _ in
                    self.formValidate()
                }
            }
            
            +++ Section("idea")
            <<< TextRow("idea"){ row in
                row.placeholder = "What idea have you get?"
                
                row.add(ruleSet: rules)
                row.validationOptions = .validatesOnDemand
                
                row.onChange { _ in
                    self.formValidate()
                }
            }
            
            +++ Section("understanding")
            <<< TextAreaRow("understanding"){ row in
                row.placeholder = "Your understanding about the idea"
                
                row.add(ruleSet: rules)
                row.validationOptions = .validatesOnDemand
                
                row.onChange { _ in
                    self.formValidate()
                }
            }
                    
            +++ Section("opinion")
            <<< TextAreaRow("opinion"){ row in
                row.placeholder = "Your opinion about story delivering"
                
                row.add(ruleSet: rules)
                row.validationOptions = .validatesOnDemand
                
                row.onChange { _ in
                    self.formValidate()
                }
            }
                    
            +++ Section("emotion")
            <<< TextRow("emotion"){ row in
                row.placeholder = "What kind of emotion do you feel?"
                
                row.add(ruleSet: rules)
                row.validationOptions = .validatesOnDemand
                
                row.onChange { _ in
                    self.formValidate()
                }
            }
        
        }
    
    
    @IBAction func playbackAction(_ sender: UIBarButtonItem) {
        toggleState()
    }
    
    func updatePlaybackState() {
        switch playbackState {
        case .playing:
            playbackButton.image = UIImage(named: "pausebutton")
            
            playback.play { completed in
                if completed {
                    self.toggleState()
                }
            }
        case .stopped:
            playbackButton.image = UIImage(named: "playbutton")
            
            playback.stop()
        default:
            return
        }
    }
    
    func toggleState() {
        if playbackState == .playing {
            playbackState = .stopped
        } else  {
            playbackState = .playing
        }
    }
}
