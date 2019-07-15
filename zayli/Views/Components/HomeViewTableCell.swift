//
//  HomeViewTableCell.swift
//  zayli
//
//  Created by rshier on 15/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit

class HomeViewTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    private var id: String!
    
    func populate(with practice: Practice) {
        id = practice.id
        titleLabel.text = practice.idea
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}