//
//  PracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UITableViewController {

    private var practices: Results<Practice>?
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func setupData() {
        // Autodelete realm if theres migration
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        
        practices = Realm.shared.objects(Practice.self).sorted(
            byKeyPath: "timestamp", ascending: false
        )
    }
    
}

// Mark: - Table-related stuff

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let practice = practices![indexPath.row]
        setTempId(practice.id)
        
        self.performSegue(withIdentifier: "GoPracticeDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let practice = practices![indexPath.row]
        setTempId(practice.id)
        self.performSegue(withIdentifier: "GoRecordingDetail", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

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
