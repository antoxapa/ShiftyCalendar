//
//  MonthNameHeader.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/14/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MonthNameHeader: UICollectionReusableView {
    
    @IBOutlet weak var monthNameCV: UICollectionView!
    
    let monthNameCellID = "monthNameCell"
    let emptyCellID = "emptyCell"
    
    var monthModel: CalendarMonth!
    
    
    func configureHeader(model: CalendarMonth) {
        self.monthModel = model
        DispatchQueue.main.async {
            self.monthNameCV.reloadData()
        }
    }
}

extension MonthNameHeader: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthNameCellID, for: indexPath) as? MonthNameCell else { return UICollectionViewCell() }
        cell.MonthNameLabel.text = ""
        if monthModel.skipCount == indexPath.row {
            cell.MonthNameLabel.text = monthModel.monthName
        }
        return cell
    }
}


extension MonthNameHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sireForItem = monthNameCV.frame.width / 7
        return CGSize(width: sireForItem, height: sireForItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
