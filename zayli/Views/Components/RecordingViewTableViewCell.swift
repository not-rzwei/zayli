//
//  RecordingViewTableViewCell.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import SwiftDate

class RecordingViewTableViewCell: UITableViewCell {

    // MARK: - Cell Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var playLabel: UIButton!
    
    private var id: String?
    
    func populate(_ record: Record, _ number: Int){
        titleLabel.text = "Record \(number)"
        feedbackLabel.text = "\(record.feedbacks.count) feedbacks"
        dateLabel.text = Date(timeIntervalSince1970: record.timestamp).toRelative()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()u
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
