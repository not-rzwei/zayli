//
//  FeedbackViewController.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift
import UIEmptyState

class FeedbackViewController: UITableViewController, UIEmptyStateDataSource, UIEmptyStateDelegate {

    private var feedbacks: Results<Feedback>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyState()
        setupData()
        setupUI()
    }
    
    func setupUI(){
        let number = getTempId("recordNumber")
        title = "Record \(number) Feedback"
    }
    
    func setupData() {
        let id = getTempId("recordId")
        let record = Realm.shared.object(ofType: Record.self, forPrimaryKey: id)
        
        feedbacks = record?.feedbacks.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    func setupEmptyState(){
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.reloadEmptyState()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackViewTableViewCell
        let feedback = feedbacks?[indexPath.row] as! Feedback
        
        cell.populate(with: feedback)
        
        return cell
    }

}

extension FeedbackViewController {
    var emptyStateTitle: NSAttributedString {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)
        ]
        
        return NSAttributedString(string: "There is no Feedback yet!", attributes: attrs)
    }
    
    var emptyStateDetailMessage: NSAttributedString? {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
        ]
        
        return NSAttributedString(string: "You can add feedback now", attributes: attrs)
    }
    
    var emptyStateImage: UIImage? {
        return UIImage(named: "onboard3")
    }
    
    var emptyStateImageSize: CGSize? {
        return CGSize(width: 256, height: 256)
    }
    
}
