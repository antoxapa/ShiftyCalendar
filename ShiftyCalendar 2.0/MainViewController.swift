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
    var monthModels = [CalendarMonth]()
    private var firstEventDay: Date?
    private var eventColor: UIColor?
    private var eventName: String?
    private var repeating: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        createDataBase()
        getPlist()
    }
    
    
    // MARK:- Action
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? Event else { return }
        if segue.identifier == "cancel" {
            print("Cancelled")
        } else {
            if  segue.identifier == "done" {
                let eventDay = svc.startDate
                let eventName = svc.setName
                let eventColor = svc.setColor!.toHexString()
                let repeating = svc.repeating
                print("data uploaded")
                
                DispatchQueue.main.async {
                    do {
                        let eventInfo: [String : Any] = ["eventDay": eventDay!, "eventName": eventName!, "eventColor": eventColor, "repeating": repeating!]
                        try savePropertyList(eventInfo)
                        print(eventInfo.values)
                    } catch {
                        print("error")
                    }
                    self.getPlist()
                    self.monthCollectionView.reloadData()
                }
            }
        }
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
    
    func getPlist() {
        do {
            let eventInfo = try loadPropertyList()
            
            guard let firstDay = eventInfo["eventDay"] as? Date else { return }
            self.firstEventDay = firstDay
            
            guard let name = eventInfo["eventName"] as? String else { return }
            self.eventName = name
            
            guard let color = eventInfo["eventColor"] as? String else { return }
            self.eventColor = UIColor(hexString: color)
            guard let repeating = eventInfo["repeating"] as? String else { return }
            self.repeating = repeating
        } catch {
            print("no data")
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
        if firstEventDay != nil {
            cell.configureEvent(eventName: eventName!, eventColor: eventColor!, firstEventDay: firstEventDay!, repeating: repeating!)
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getCellHeight(for: indexPath)
        return CGSize(width: monthCollectionView.frame.width, height: height + 40)
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    public convenience init? (hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
