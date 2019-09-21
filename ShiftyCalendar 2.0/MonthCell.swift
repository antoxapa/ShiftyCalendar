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

    var monthModelArray = [CalendarMonth]()
    
    func configureCell(model: CalendarMonth) {
        monthModelArray.append(model)
        for (value, index) in monthModelArray.enumerated() {
            print("item: \(index), \(value)")
        }
        
    }
    
}

// MARK:- Extansions

extension MonthCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellID, for: indexPath) as? DayCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID , for: indexPath) as? MonthNameHeader else {
                return UICollectionReusableView()
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
