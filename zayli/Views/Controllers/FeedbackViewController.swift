//
//  FeedbackViewController.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift


class FeedbackViewController: UITableViewController {

    private var feedbacks: Results<Feedback>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    func setupData() {
        let id = getTempId("recordId")
        let record = Realm.shared.object(ofType: Record.self, forPrimaryKey: id)
        
        feedbacks = record?.feedbacks.sorted(byKeyPath: "timestamp", ascending: false)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedbacks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackViewTableViewCell
        let feedback = feedbacks?[indexPath.row] as! Feedback
        
        cell.populate(with: feedback)
        
        return cell
    }

}
