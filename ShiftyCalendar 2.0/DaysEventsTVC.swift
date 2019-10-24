//
//  DaysEventsTVC.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/24/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class DaysEventsTVC: UITableViewCell {
    @IBOutlet weak var eventColorView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
