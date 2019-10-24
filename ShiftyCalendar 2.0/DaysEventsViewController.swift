//
//  DaysEventsViewController.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/6/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class DaysEventsViewController: UIViewController {

    @IBOutlet weak var dayInfoView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var daysEventsTV: UITableView!
    
    let cellID = "eventCell"
    
    var eventNames: [String] = []
    var eventFirstDay: Date?
    var eventColor: UIColor?
    var eventRepeat: String?
    
    var selectedDay: String?
    var selectedMonth: String?
    var selectedYear: Int?
    var isMarked: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getPlist()
            self.daysEventsTV.reloadData()
        }

    }
    
   
    func getPlist() {
        
        do {
        let eventInfo = try loadPropertyList()
            
            guard let firstDay = eventInfo["eventDay"] as? Date else { return }
            self.eventFirstDay = firstDay
            
            guard let name = eventInfo["eventName"] as? String else { return }
            self.eventNames.append(name)
            
            guard let color = eventInfo["eventColor"] as? String else { return }
            self.eventColor = UIColor(hexString: color)
            
            guard let repeating = eventInfo["repeating"] as? String else { return }
            self.eventRepeat = repeating
            
        } catch {
            print("error")
        }
    }
}

extension DaysEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID , for: indexPath) as? DaysEventsTVC else { return UITableViewCell() }
        if isMarked == true {
        cell.eventColorView.backgroundColor = eventColor
        cell.eventNameLabel.text = eventNames[indexPath.item]
        }
        return cell
    }
    
    
}
