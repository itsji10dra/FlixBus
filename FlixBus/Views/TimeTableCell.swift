//
//  TimeTableCell.swift
//  FlixBus
//
//  Created by Jitendra on 29/03/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class TimeTableCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lineInfoLabel: UILabel!
    @IBOutlet weak var throughStationsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        throughStationsLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
