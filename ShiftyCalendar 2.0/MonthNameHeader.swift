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
}

extension MonthNameHeader: UICollectionViewDelegate {
    
}

extension MonthNameHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthNameCellID, for: indexPath) as? MonthNameCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
