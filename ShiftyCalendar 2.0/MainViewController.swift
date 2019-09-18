//
//  MainViewController.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
    
    public var monthModels = [CalendarMonth]()
    let weekStartDay = WeekStartDay.monday
    var skipCountArray =  [Int]()
    
    
    let monthCellID = "monthCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataModel()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self

        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    private func createDataModel() {
        var startDate = todayDate
        let endDate = todayDate.getDateAfter(year: 1, month: 0)
        
        
        while startDate <= endDate {
            let getMonthData = startDate.getMonth()
            let month = (CalendarMonth(year: getMonthData.year, monthNumber: getMonthData.month, monthName: getMonthData.name))
            monthModels.append(month)
            let weekDayNo = getDayOfWeek(year: month.year, month: month.monthNumber)
            let skipCount = getSkipCount(weekDayNo, startDay: weekStartDay)
            skipCountArray.append(skipCount)
            startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
//            print(month.monthName)
        }
        DispatchQueue.main.async { [weak self] in
            self?.monthCollectionView.reloadData()
        }
    }
    //    fileprivate func getTotalNumberOfItems(model: CalendarMonth) -> Int{
    //        let days = getNumberOfDaysInMonth(year: model.year, month: model.monthNumber)
    //        let weekDay = getDayOfWeek(year: model.year, month: model.monthNumber)
    //        let skipCount = getSkipCount(weekDay, startDay: self.weekStartDay)
    //        let totalCellsInMonth = days + skipCount
    //
    //        print(totalCellsInMonth)
    //        return totalCellsInMonth
    //    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthCellID, for: indexPath) as? MonthCell else { return UICollectionViewCell() }
//        cell.configureCell(model: monthModels[indexPath.item], skipCount: skipCountArray[indexPath.row])
        
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getMonthCellHeight(for: indexPath)
        
        return CGSize(width: monthCollectionView.frame.width, height: height + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension MainViewController {
    fileprivate func getNumberOfItems(model: CalendarMonth, indexPath: IndexPath) -> Int{

        let totalDays = getNumberOfDaysInMonth(year: model.year, month: model.monthNumber)
        let skipCount = skipCountArray[indexPath.row]
        return totalDays + skipCount
    }

    fileprivate func getMonthCellHeight(for indexPath: IndexPath) -> CGFloat {
        let model = monthModels[indexPath.row]
        let factor = monthCollectionView.frame.width / 7
        let totalDaysInMonth = getNumberOfItems(model: model, indexPath: indexPath)
        let height = CGFloat(ceil(Double(totalDaysInMonth) / 7.0)) * factor
        return height
    }
}

//
//extension UIView{
//
//    @IBInspectable var shadowOffset: CGSize{
//        get{
//            return self.layer.shadowOffset
//        }
//        set{
//            self.layer.shadowOffset = newValue
//        }
//    }
//
//    @IBInspectable var shadowColor: UIColor{
//        get{
//            return UIColor(cgColor: self.layer.shadowColor!)
//        }
//        set{
//            self.layer.shadowColor = newValue.cgColor
//        }
//    }
//
//    @IBInspectable var shadowRadius: CGFloat{
//        get{
//            return self.layer.shadowRadius
//        }
//        set{
//            self.layer.shadowRadius = newValue
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float{
//        get{
//            return self.layer.shadowOpacity
//        }
//        set{
//            self.layer.shadowOpacity = newValue
//        }
//    }
//}
