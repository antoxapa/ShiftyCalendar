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
    
    @IBOutlet weak var dayCellSubView: UIView! {
        didSet {
            dayCellSubView.backgroundColor = .lightGray
            dayCellSubView.alpha = 0.3
        }
    }
    @IBOutlet weak var cellBGView: UIView! 
    
    var currentYear: Int!
    var currentMonth: Int!
    var daysModel: CalendarDay!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpToday(model: CalendarDay) {
        if Today.todayDate.isSame(getDate(model: model)) {
            dayLabel.textColor = .white
            cellBGView.layer.backgroundColor = UIColor.red.cgColor
            cellBGView.layer.cornerRadius = cellBGView.frame.width / 2
            cellBGView.layer.masksToBounds = true
        } else {
            dayLabel.textColor = .black
            cellBGView.layer.backgroundColor = UIColor.white.cgColor
            cellBGView.layer.cornerRadius = 0
            cellBGView.layer.masksToBounds = false
        }
    }
    
    func configureDayCell(model: CalendarDay) {
        self.daysModel = model
        if let day = model.day {
        dayLabel.text = String(describing: day)
        setUpToday(model: daysModel)
        }
    }
}

extension DayCell {
    fileprivate func getDate(model: CalendarDay) -> Date? {
        return getDateFrom(year: currentYear, month: currentMonth, day: model.day)
    }
}
