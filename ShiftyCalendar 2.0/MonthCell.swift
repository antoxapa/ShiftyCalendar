//
//  MonthCell.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    
    // MARK:- Outlet
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    // MARK:- Constants
    let monthCellID = "monthCell"
    let dayCellID = "dayCell"
    let emptyCellID = "emptyCell"
    let headerID = "header"
    
    // MARK:- Variables
    var monthModel: CalendarMonth!
    var currentYear = 2019
    var currentMonth = 1
    var currentMonthName = "January"
    var skipCount = 0
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: CalendarMonth) {
        self.monthModel = model
        self.currentYear = model.year
        self.currentMonth = model.monthNumber
        self.skipCount = model.skipCount
        self.currentMonthName = model.monthName
        DispatchQueue.main.async {
            self.daysCollectionView.reloadData()
        }
    }
    
    
}

// MARK:- Extansions
extension MonthCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModel.days.count + skipCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < skipCount {
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellID, for: indexPath) as? DayCell else {
            return UICollectionViewCell()
        }
        cell.configureDayCell(model: monthModel.days[indexPath.row - skipCount])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID , for: indexPath) as? MonthNameHeader else { return UICollectionReusableView() }
            header.configureHeader(model: monthModel)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeForItem = daysCollectionView.frame.width / 7
        return CGSize(width: sizeForItem, height: sizeForItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
}

