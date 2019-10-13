//
//  EventsListVC.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class EventsListVC: UIViewController {

    @IBOutlet weak var eventTableVIew: UITableView!
    
    private var cellID = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EventsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EventsListCell else { return UITableViewCell() }
        return cell
    }
    
    
}
