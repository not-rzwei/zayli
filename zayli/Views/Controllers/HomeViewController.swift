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
        let realm = try! Realm()
        
        practices = realm.objects(Practice.self).sorted(
            byKeyPath: "timestamp", ascending: false
        )
    }
    
     // MARK: - Navigation
    
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "GoPracticeDetail":
//            let practiceDetail = segue.destination as! PracticeDetailViewController
//            practiceDetail.practice = sender as? Practice
//        default:
//            return
//        }
//     }
}

// Mark: - Table-related stuff

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let practice = practices![indexPath.row] as Practice
        
        self.performSegue(withIdentifier: "GoPracticeDetail", sender: practice)
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
