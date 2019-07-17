//
//  FeedbackViewTableViewCell.swift
//  zayli
//
//  Created by rshier on 17/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit

class FeedbackViewTableViewCell: UITableViewCell {

    @IBOutlet weak var ideaLabel: UILabel!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func populate(with feedback: Feedback){
        ideaLabel.text = feedback.idea
        emotionLabel.text = feedback.emotion
        nameLabel.text = feedback.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
