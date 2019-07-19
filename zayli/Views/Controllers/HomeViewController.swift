//
//  PracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift
import UIEmptyState

class HomeViewController: UITableViewController, UIEmptyStateDataSource, UIEmptyStateDelegate {

    private var practices: Results<Practice>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyState()
        setupData()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func setupData() {
        practices = Realm.shared.objects(Practice.self).sorted(
            byKeyPath: "timestamp", ascending: false
        )
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

// Mark: - Table-related stuff

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let practice = practices![indexPath.row]
        setTempId(practice.id)
        
        self.performSegue(withIdentifier: "GoRecordingDetail", sender: self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.practices?.count ?? 0
    }

    
    // MARK: - Table cell configuration
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeCell", for: indexPath) as! HomeViewTableCell
        let practice = practices![indexPath.row] as Practice

        cell.populate(with: practice)

        return cell
    }

}

extension HomeViewController {
    var emptyStateTitle: NSAttributedString {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)
        ]
        
        return NSAttributedString(string: "Let's Convey Your Idea!", attributes: attrs)
    }
    
    var emptyStateButtonSize: CGSize? {
        return CGSize(width: 200, height: 20)
    }
    
    var emptyStateButtonTitle: NSAttributedString? {
        let attrs = [
            NSAttributedString.Key.foregroundColor: view.tintColor,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
        ]
        
        return NSAttributedString(string: "New Idea", attributes: attrs)
    }
    
    
    func emptyStatebuttonWasTapped(button: UIButton) {
        performSegue(withIdentifier: "GoNewPractice", sender: nil)
    }
    
    var emptyStateImage: UIImage? {
        return UIImage(named: "onboard1")
    }
    
    var emptyStateImageSize: CGSize? {
        return CGSize(width: 256, height: 256)
    }
}
