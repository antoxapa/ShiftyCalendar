//
//  EventsListCell.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class EventsListCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventCheckButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func eventInfoButtonPressed(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
