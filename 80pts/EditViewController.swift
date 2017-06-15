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
    @IBOutlet weak var nameBlocker: UIButton!
    
    var tempName = ""

}


extension EditViewController: UITextFieldDelegate {

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.addTarget(self, action: #selector(typingName), for: .editingChanged)
        
        beautitfy()
    }
    
    
    func nameEditModeBegin() {
       
        nameBlocker.isHidden = false
        nameField.becomeFirstResponder()
        navigationController?.isNavigationBarHidden = true


    }
    
    func nameEditEnd () {

        
        nameBlocker.isHidden = true
        nameField.resignFirstResponder()

        let countedDuplicateNames = People.duplicateName(name: tempName)
        
        if countedDuplicateNames > 0  {
            tempName = "\(tempName) \(countedDuplicateNames)"
        }
        
        Selected.person.name = tempName
        
        nameField.resignFirstResponder()
        navigationController?.isNavigationBarHidden = false

        
    }
    
    func typingName(textField:UITextField){
        
        if let typedText = textField.text {
            tempName = typedText
        }
    }
    
    func beautitfy() {
        
        if Selected.person.name == Text.noName {
            nameEditModeBegin()
            
        } else {
            nameField.text = Selected.person.name
            nameBlocker.isHidden = true
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
    
    @IBAction func blockerTouched(_ sender: Any) {
        
        nameEditEnd()
        
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        nameEditModeBegin()
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        tempName = textField.text ?? ""
    
        nameEditEnd()
        
       
        return true
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        persistSelectedEmployee(person: Selected.person)
        People.persist(ppl: list)

    }
    
}




