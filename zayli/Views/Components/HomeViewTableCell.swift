//
//  HomeViewTableCell.swift
//  zayli
//
//  Created by rshier on 15/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import SwiftDate
import RealmSwift

class HomeViewTableCell: UITableViewCell {

    // MARK: - Cell outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    private var id: String!
    
    func populate(with practice: Practice) {
        id = practice.id
        let feedbackCount = calculateFeedback(practice.records)
        
        titleLabel.text = practice.idea
        recordLabel.text = "\(practice.records.count) records"
        feedbackLabel.text = "\(feedbackCount) feedbacks"
        dateLabel.text = Date(timeIntervalSince1970: practice.timestamp).toRelative()
    }
    
    func calculateFeedback(_ records: List<Record>) -> Int{
        var feedbackCount = 0
        records.forEach { record in
            feedbackCount += record.feedbacks.count
        }
        
        return feedbackCount
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func detailAction(_ sender: UIButton) {
        UserDefaults.standard.set(id, forKey: "tempId")
    }
}
