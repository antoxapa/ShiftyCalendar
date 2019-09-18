//
//  MonthNameHeader.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/14/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MonthNameHeader: UICollectionReusableView {
    
    var skipCount: Int!
    var monthName: String!
    
    @IBOutlet weak var monthNameCV: UICollectionView!
    
    let monthNameCellID = "monthNameCell"
    let emptyCellID = "emptyCell"

    override func awakeFromNib() {
        super .awakeFromNib()
    }
    func configureHederCell(skipCount: Int, monthName: String) {
        self.skipCount = skipCount
        self.monthName = monthName
    }
}
extension MonthNameHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skipCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if skipCount > indexPath.row {
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthNameCellID, for: indexPath) as? MonthNameCell else { return UICollectionViewCell() }
        cell.configure
        return cell
    }
    
    
}
