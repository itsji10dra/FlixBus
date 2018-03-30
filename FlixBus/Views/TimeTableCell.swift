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
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var lineInfoLabel: UILabel!
    @IBOutlet weak private var throughStationsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLabel.numberOfLines = 2
        throughStationsLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(data: TimeTableInfo) {
        
        let time = data.dateTimeInfo?.getLocalTime(.HH_colon_mm_line_dd_space_MMM_comma_space_yy)
        self.timeLabel.text = time?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let lineInfoText = "Line " + (data.lineCode ?? "") + " direction " + (data.direction ?? "")
        self.lineInfoLabel.text = lineInfoText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.throughStationsLabel.text = "to " + (data.throughStations ?? "")
    }
}
