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
        monthNameCV.delegate = self
        monthNameCV.dataSource = self
    }
    func configureHederCell(skipCount: Int, monthName: String) {
        self.skipCount = skipCount
        self.monthName = monthName
    }
}
extension MonthNameHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthNameCellID, for: indexPath) as? MonthNameCell else { return UICollectionViewCell() }
//        cell.MonthNameLabel.text = monthName
//        if indexPath.row < skipCount {
//
//        cell.isHidden = true
//
//        } else {
//            if indexPath.row > skipCount {
//                cell.isHidden = true
//            }
//        }
        return cell
    }
    
    
}
