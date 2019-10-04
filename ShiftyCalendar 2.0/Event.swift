//
//  Event.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/3/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import UIKit

class Event: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var colorStackView: UIStackView!
    @IBOutlet weak var redColor: UIButton! {
        didSet {
            redColor.layer.cornerRadius = redColor.bounds.width / 2
        }
    }
    @IBOutlet weak var greenColor: UIButton! {
        didSet {
            greenColor.layer.cornerRadius = greenColor.bounds.width / 2
        }
    }
    @IBOutlet weak var yellowColor: UIButton! {
        didSet {
            yellowColor.layer.cornerRadius = yellowColor.bounds.width / 2
        }
    }
    @IBOutlet weak var blueColor: UIButton! {
        didSet {
            blueColor.layer.cornerRadius = blueColor.bounds.width / 2
        }
    }
    @IBOutlet weak var purpleColor: UIButton! {
        didSet {
            purpleColor.layer.cornerRadius = purpleColor.bounds.width / 2
        }
    }
    @IBOutlet weak var orangeColor: UIButton! {
        didSet {
            orangeColor.layer.cornerRadius = orangeColor.bounds.width / 2
        }
    }
    @IBOutlet weak var tealColor: UIButton! {
        didSet {
            tealColor.layer.cornerRadius = tealColor.bounds.width / 2
        }
    }
    @IBOutlet weak var grayColor: UIButton! {
        didSet {
            grayColor.layer.cornerRadius = grayColor.bounds.width / 2
        }
    }
    
    var startDate: Date?
    var setColor: UIColor?
    var setName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.becomeFirstResponder()
        
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    
    @IBAction func setStartDate(_ sender: UIDatePicker) {
        startDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let dateValue = dateFormatter.string(from: sender.date)
        print(dateValue)
    }
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        self.setColor = sender.backgroundColor
    }
   
    @objc private func textFieldDidChange() {
        setName = nameTF.text
    }
    
    // MARK: - Navigation
}


