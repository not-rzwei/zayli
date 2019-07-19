//
//  RecordingViewController.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift
import UIEmptyState

class RecordingViewController: UITableViewController, UIEmptyStateDataSource, UIEmptyStateDelegate {
    
    private var practice: Practice?
    private var records: Results<Record>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyState()
        setupData()
        setupUI()
    }
    
    func setupData(){
        let id = getTempId()
        
        practice = Realm.shared.object(ofType: Practice.self, forPrimaryKey: id)
        records = practice?.records.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    func setupUI(){
        title = practice?.idea
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
    
}

extension RecordingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordingViewTableViewCell
        let record = records?[indexPath.row] as! Record
        let number = records!.count - indexPath.row
        
        cell.populate(record, number)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records?[indexPath.row]
        let number = records!.count - indexPath.row
        
        setTempId(record!.id, key: "recordId")
        setTempId(String(describing: number), key: "recordNumber")
        
        performSegue(withIdentifier: "GoFeedbackList", sender: nil)
        
    }
    
}

extension RecordingViewController {
    var emptyStateTitle: NSAttributedString {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)
        ]
        
        return NSAttributedString(string: "There is no Recording yet!", attributes: attrs)
    }
    
    var emptyStateDetailMessage: NSAttributedString? {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
        ]
        
        return NSAttributedString(string: "You can add recording now", attributes: attrs)
    }
    
}
