//
//  MonthCell.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    var monthModel: CalendarMonth?
    let weekStartDay = WeekStartDay.monday
    
    var currentYear: Int?
    var currentMonth: Int?
    var skipCount: Int!
    
    let dayCellID = "dayCell"
    let emptyCellID = "emptyCell"
    let headerID = "header"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
    }
    
//    func loadCollection() {
//        let weekdayNumber = getDayOfWeek(year: currentYear!, month: currentMonth!)
//        skipCount = getSkipCount(weekdayNumber, startDay: weekStartDay)
//    }
    
    func configureCell(model: CalendarMonth, skipCount: Int) {
        
        self.monthModel = model
        self.currentYear = model.year
        self.currentMonth = model.monthNumber
        self.skipCount = skipCount
        }
    }

extension MonthCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = monthModel {
            return model.days.count + skipCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < skipCount {
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellID, for: indexPath) as? DayCell else { return UICollectionViewCell() }
        if let model = self.monthModel {
        cell.configureCell(model: (model.days[indexPath.item - skipCount]))
        cell.iventView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? MonthNameHeader else { return UICollectionReusableView() }
            headerView.configureHederCell(skipCount: skipCount, monthName: monthModel!.monthName)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

extension MonthCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.0
        return CGSize(width: width, height: width)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
