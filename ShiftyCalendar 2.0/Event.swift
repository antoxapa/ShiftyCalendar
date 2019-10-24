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
    @IBOutlet weak var doneButton: UIBarButtonItem! {
        didSet {
            doneButton.isEnabled = false
        }
    }
    
    @IBOutlet var boxes : [UIButton]! {
        didSet {
            boxes.forEach {
                $0.layer.cornerRadius = $0.bounds.width / 2
            }
            boxes[0].isHighlighted = true
            boxes[0].setShadow(for: .highlighted)
        }
    }
    
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var repeatNameLabel: UILabel!
    
    var startDate: Date? = Today.todayDate
    var setColor: UIColor? = .red
    var setName: String?
    var repeating: String? = "never"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.becomeFirstResponder()
        if startDate == nil, setName == nil, setColor == nil, repeating == nil {
            doneButton.isEnabled = false
        }
    }
    
    @IBAction func boxTouched(_ sender: UIButton) {
        for item in boxes {
            item.isHighlighted = false
            item.removeShadow(for: .normal)
            
            if item.tag == sender.tag {
                item.isHighlighted = true
                item.setShadow(for: .highlighted)
                setColor = item.backgroundColor
                
            }
        }
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    
    @IBAction func setStartDate(_ sender: UIDatePicker) {
        startDate = sender.date
    }
    @objc private func textFieldDidChange() {
        setName = nameTF.text
        doneButton.isEnabled = true
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToEventVC(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? RepeatTVC else { return }
        switch segue.identifier {
        case "everyday":
            repeating = "everyday"
            repeatNameLabel.text = "Everyday"
        case "twodays":
            repeating = "twodays"
            repeatNameLabel.text = "Two days"
        case "everyweek":
            repeating = "everyweek"
            repeatNameLabel.text = "Every week"
        case "everyMonth":
            repeating = "everyMonth"
            repeatNameLabel.text = "Every month"
        case "never" :
            repeating = "never"
            repeatNameLabel.text = "Never"
        default:
            print("default")
        }
    }
}


extension UIButton {
    func setShadow(for state: UIControl.State) {
        layer.borderWidth = 2
        let borderColor = UIColor.white
        layer.borderColor = borderColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
    }
    
    func removeShadow(for state: UIControl.State) {
        layer.borderWidth = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
    }
}
