//
//  ViewController.swift
//  80pts
//
//  Created by Levy,David A. on 12/21/16.
//  Copyright © 2016 mcc. All rights reservevar//

import UIKit


class EditViewController: UIViewController {
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var startDayPicker: UIDatePicker!
    @IBOutlet weak var wagesReplacedLabel: UILabel!
    @IBOutlet weak var wagesReplacedStepper: UIStepper!
    @IBOutlet weak var nameField: UITextField!

}


extension EditViewController: UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        beautitfy()
    }
    
    
    func beautitfy() {
                
        if Selected.person.name == Text.noName {
            nameField.becomeFirstResponder()
        } else {
            nameField.text = Selected.person.name
        }
        
        wagesReplacedLabel.text = "Wages: \(Selected.person.percentOfWages)%"
        wagesReplacedStepper.minimumValue = 0.0
        wagesReplacedStepper.maximumValue = Double(Wage.options.count) - 1
        wagesReplacedStepper.value = wageIndex(person: Selected.person)
        
        birthdayPicker.backgroundColor = UIColor.white
        birthdayPicker.setValue(UIColor.black, forKeyPath: "textColor")
        birthdayPicker.setValue(1.0, forKeyPath: "alpha")
        birthdayPicker.setDate( dateFromArray(arr: Selected.person.birthday), animated: true)
        
        startDayPicker.backgroundColor = UIColor.white
        startDayPicker.setValue(UIColor.black, forKeyPath: "textColor")
        startDayPicker.setValue(1.0, forKeyPath: "alpha")
        startDayPicker.setDate( dateFromArray(arr: Selected.person.started), animated: true)
        startDayPicker.maximumDate = dateFromArray(arr: dateArray.today)
        
        UIApplication.shared.statusBarStyle = .default
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func wagesAdjusted(_ sender: Any) {
        
        
       let newOption = newWagePercentage(stepperIndex: wagesReplacedStepper.value)
        Selected.person.percentOfWages = newOption.percent
        Selected.person.wageMultiplier = newOption.multiplier
        Selected.person.wageYearsRequired = newOption.years
        
        wagesReplacedLabel.text = "Wages: \(Selected.person.percentOfWages)%"
        
        
        
    }
    

    
    @IBAction func bDayAction(_ sender: Any) {
        let shortFormat = DateFormatter()
        shortFormat.dateStyle = DateFormatter.Style.short
        let strDate = shortFormat.string(from: birthdayPicker.date)
        let shortStrArray = strDate.components(separatedBy:"/")
        
        let longFormat = DateFormatter()
        longFormat.dateStyle = DateFormatter.Style.medium
        let longDate = longFormat.string(from: birthdayPicker.date)
        let longStrArray = longDate.components(separatedBy:" ")
        
        Selected.person.birthday = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]
    }
    
    @IBAction func stDayAction(_ sender: Any) {
        let shortFormat = DateFormatter()
        shortFormat.dateStyle = DateFormatter.Style.short
        let strDate = shortFormat.string(from: startDayPicker.date)
        let shortStrArray = strDate.components(separatedBy:"/")
        
        let longFormat = DateFormatter()
        longFormat.dateStyle = DateFormatter.Style.medium
        let longDate = longFormat.string(from: startDayPicker.date)
        let longStrArray = longDate.components(separatedBy:" ")

        Selected.person.started = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]
        Selected.person.batch = inferBatch(hireDate: dateFromArray(arr: Selected.person.started))
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        //FIXME:  If client puts a number in the newName it messes things up a bit.
        
        var newName: String = textField.text ?? ""
    
        let countedDuplicateNames = People.duplicateName(name: newName)
        
        if countedDuplicateNames > 0  {
            newName = "\(newName) \(countedDuplicateNames)"
        }

        Selected.person.name = newName
        
        nameField.resignFirstResponder()
       
        return true
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        persistSelectedEmployee(person: Selected.person)
        People.persist(ppl: list)

    }
    
}




