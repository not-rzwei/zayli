//
//  FeedbackViewTableViewCell.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit

class FeedbackViewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func populate(with feedback: Feedback){
        nameLabel.text = feedback.name
        dateLabel.text = "Created " + Date(timeIntervalSince1970: feedback.timestamp).toRelative()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
