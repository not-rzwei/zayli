//
//  PracticeViewController.swift
//  zayli
//
//  Created by rshier on 12/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

// Mark: - Table-related stuff

extension HomeViewController {

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Practice"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    // MARK: - Table cell configuration
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeCell", for: indexPath)
        
        cell.textLabel?.text = "Blockchain Technology"
        cell.detailTextLabel?.text = "19/09/09"
        cell.detailTextLabel?.textColor = .gray

        return cell
    }

}
