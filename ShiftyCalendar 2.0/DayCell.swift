//
//  DayCell.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit
import Foundation

class DayCell: UICollectionViewCell{
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var dayCellSubView: UIView! {
        didSet {
            dayCellSubView.backgroundColor = .lightGray
            dayCellSubView.alpha = 0.3
        }
    }
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var eventView: UIView! {
        didSet {
            eventView.layer.cornerRadius = eventView.frame.width / 2
            eventView.isHidden = true
        }
    }
    
    var currentYear: Int!
    var currentMonth: Int!
    var daysModel: CalendarDay!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        eventView.isHidden = true
        eventView.backgroundColor = .clear
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
    
    func configureEvent(eventName: String, eventColor: UIColor, firstEventDay: Date, repeating: String) {
        
        if firstEventDay.isSame(getDate(model: daysModel)) {
            eventView.isHidden = false
            eventView.backgroundColor = eventColor
        }
        
        switch repeating {
        case "everyday":
            DispatchQueue.main.async {
                var startDate = firstEventDay
                let endDate = firstEventDay.getDateAfter(year: 0, month: 1)
                while startDate <= endDate {
                    if startDate.isSame(self.getDate(model: self.daysModel)) {
                        self.eventView.isHidden = false
                        self.eventView.backgroundColor = eventColor
                    }
                    startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
                }
            }
            
        case "twodays":
            var startDate = firstEventDay
            let endDate = firstEventDay.getDateAfter(year: 0, month: 1)
            while startDate <= endDate {
                if startDate.isSame(getDate(model: daysModel)) {
                    self.eventView.isHidden = false
                    self.eventView.backgroundColor = eventColor
                }
                startDate = Calendar.current.date(byAdding: .day, value: 2, to: startDate)!
            }
        case "everyweek":
            var startDate = firstEventDay
            let endDate = firstEventDay.getDateAfter(year: 0, month: 2)
            while startDate <= endDate {
                if startDate.isSame(getDate(model: daysModel)) {
                    self.eventView.isHidden = false
                    self.eventView.backgroundColor = eventColor
                }
                startDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
            }
        case "everyMonth":
            var startDate = firstEventDay
            let endDate = firstEventDay.getDateAfter(year: 0, month: 2)
            while startDate <= endDate {
                if startDate.isSame(getDate(model: daysModel)) {
                    self.eventView.isHidden = false
                    self.eventView.backgroundColor = eventColor
                }
                startDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
            }
            
        default:
            print("default")
        }
    }
}


extension DayCell {
    fileprivate func getDate(model: CalendarDay) -> Date? {
        return getDateFrom(year: currentYear, month: currentMonth, day: model.day)
    }
}

