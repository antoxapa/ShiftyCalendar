//
//  DayCell.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iventView: UIView!
    @IBOutlet weak var dayCellSubView: UIView!
    
    
    func configureDayCell(model: CalendarDay) {
        if let day = model.day {
        dayLabel.text = String(describing: day)
            iventView.backgroundColor = .white
        }
        dayCellSubView.alpha = 0.2
    }
}
