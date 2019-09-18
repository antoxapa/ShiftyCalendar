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
    

    override func awakeFromNib() {
        super .awakeFromNib()
    }
    func configureHederCell(skipCount: Int, monthName: String) {
        self.skipCount = skipCount
        self.monthName = monthName
    }
}
