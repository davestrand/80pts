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



    
    //VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupData()
        beautitfy()
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    //OUTLETS

    
    
    
    
    //ACTIONS
 

    
    @IBAction func caclulateAction(_ sender: Any) {
        setupData()
        if oldEnoughToWork() {
            showCalculatedAnswer()
        } else {
            showAgeWarning()
        }
    }
    
    @IBAction func popRate(_ sender: Any) {
        if let url = NSURL(string: "https://www.azasrs.gov/content/estimate-your-benefits"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
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
        thisEmployee.birthday = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]

        persistSelectedEmployee(employee: thisEmployee)
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

        thisEmployee.started = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]
        thisEmployee.batch = inferBatch(hireDate: dateFromArray(arr: thisEmployee.started))

        persistSelectedEmployee(employee: thisEmployee)
    }

    func persistSelectedEmployee (employee:Person) {
        //https://grokswift.com/notification-center-widget/
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: employee)
        

        if let defaultGroup = Defaults.group {
            
            defaultGroup.set("Group Save Enabled", forKey: "TEST")

            defaultGroup.set(encodedData, forKey: Key.currentEmployee)
            print("saved data I think")
        
            defaultGroup.synchronize()

        } else {
            print("DEFAULT GROUP PROBLEM")
        }
        
        
        
    }
    

    
    func locateSelectedEmployee () {
        
        if let data =  Defaults.group?.data(forKey: Key.currentEmployee), let aPerson = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
                print("\(aPerson.name) is currently stored in group data as primary person.")
            } else {
            print("There is an issue")
        }

    }
    
    func beautitfy() {
        
        birthdayPicker.backgroundColor = UIColor.white
        birthdayPicker.setValue(UIColor.black, forKeyPath: "textColor")
        birthdayPicker.setValue(1.0, forKeyPath: "alpha")
        birthdayPicker.setDate( dateFromArray(arr: thisEmployee.birthday), animated: true)
        
        startDayPicker.backgroundColor = UIColor.white
        startDayPicker.setValue(UIColor.black, forKeyPath: "textColor")
        startDayPicker.setValue(1.0, forKeyPath: "alpha")
        startDayPicker.setDate( dateFromArray(arr: thisEmployee.started), animated: true)
        startDayPicker.maximumDate = dateFromArray(arr: dateArray.today)
        
        UIApplication.shared.statusBarStyle = .default


    }
    
    
    func showCalculatedAnswer() {
        
        let fancyText = calculateRetirement(longForm: true)
        let alert = UIAlertController(title: fancyText.title, message: fancyText.body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "How Much?", style: UIAlertActionStyle.default) { action in
            self.popUpRates()
            })
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAgeWarning() {
        let alert = UIAlertController(title: "Hmm.", message: "Your starting age is \(thisEmployee.age) which is not old enough to work in Arizona.  Please check both dates to be sure they are accurate.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popUpRates() {
        
        let asrPayRates = "After working \(thisEmployee.yearsWorked) years your Percentage of Average Monthly Compensation would likely be \(calculateMonthlyCompensation(i:thisEmployee.yearsWorked)).  Remember, more Service Credits = higher percentage paid. \n5 = 10.50%\n10 = 21.00%\n15 = 31.50%\n20 = 43.00%\n23 = 49.45%\n25 = 55.00%\n27 = 59.40%\n30 = 69.00%\n32 = 73.60%\n\n\(batchText(b: thisEmployee.batch))"
        
        let alert = UIAlertController(title: "How Much?", message: asrPayRates, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    


}

extension EditViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true 
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true 
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true 
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true 
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called, \(textField.text ?? "nah")")
        thisEmployee.name = "\(textField.text ?? "Unnamed")"
        nameField.resignFirstResponder()
        return true
    }

}


