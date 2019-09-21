//
//  MainViewController.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    // MARK:- Outlet
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var daysOfWeekStackView: UIStackView!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    // MARK:- Constants
    let monthCellID = "monthCell"
    
    // MARK:- Variables
    var monthModels: [CalendarMonth] = [CalendarMonth]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        createDataBase()
    }
    
    
    private func createDataBase() {
        var startDate = Today.todayDate
        let endDate = startDate.getDateAfter(year: 1, month: 0)
        while startDate <= endDate {
            let month = startDate.getMonth()
            monthModels.append(CalendarMonth(year: month.year, monthNumber: month.month, monthName: month.name))
            startDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
            
        }
    }
}

// MARK:- Extansions

extension MainViewController {
    fileprivate func getTotalNumberOfItems(model: CalendarMonth) -> Int {
        let totalDays = getNumberOfDaysInMonth(year: model.year, month: model.monthNumber)
        let skipCount = model.skipCount
        return totalDays + skipCount!
    }
    
    fileprivate func getCellHeight(for indexPath: IndexPath) -> CGFloat {
        let model = monthModels[indexPath.row]
        let totalDays = getTotalNumberOfItems(model: model)
        let factor = view.frame.width / 7
        let height = CGFloat(ceil(Double(totalDays) / 7.0)) * factor
        return height
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthCellID, for: indexPath) as? MonthCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: monthModels[indexPath.item])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getCellHeight(for: indexPath)
        return CGSize(width: monthCollectionView.frame.width, height: height + 40)
    }
}
