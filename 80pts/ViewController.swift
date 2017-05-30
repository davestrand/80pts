//
//  ViewController.swift
//  80pts
//
//  Created by Levy,David A. on 12/21/16.
//  Copyright © 2016 mcc. All rights reservevar//

import UIKit


class ViewController: UIViewController {
    
    
    
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
    
    @IBAction func popSite(_ sender: Any) {
        if let url = NSURL(string: "https://www.azasrs.gov/content/retirement-eligibility"){ UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) }
    }
    @IBOutlet weak var bDayOutlet: UIDatePicker!
    @IBOutlet weak var stDayOutlet: UIDatePicker!

    
    
    
    
    //ACTIONS
    
    @IBAction func info(_ sender: Any) {
        popupInfo()
    }
    
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
        let strDate = shortFormat.string(from: bDayOutlet.date)
        let shortStrArray = strDate.components(separatedBy:"/")
        
        let longFormat = DateFormatter()
        longFormat.dateStyle = DateFormatter.Style.medium
        let longDate = longFormat.string(from: bDayOutlet.date)
        let longStrArray = longDate.components(separatedBy:" ")
        
        thisEmployee.birthday = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]
    }
    
    
    @IBAction func stDayAction(_ sender: Any) {
        let shortFormat = DateFormatter()
        shortFormat.dateStyle = DateFormatter.Style.short
        let strDate = shortFormat.string(from: stDayOutlet.date)
        let shortStrArray = strDate.components(separatedBy:"/")
        
        let longFormat = DateFormatter()
        longFormat.dateStyle = DateFormatter.Style.medium
        let longDate = longFormat.string(from: stDayOutlet.date)
        let longStrArray = longDate.components(separatedBy:" ")

        thisEmployee.started = [Int(shortStrArray[0])!, Int(shortStrArray[1])!, Int(longStrArray[2])! ]
        thisEmployee.batch = inferBatch(hireDate: dateFromArray(arr: thisEmployee.started))
        
    }

    
    func beautitfy() {
        
        bDayOutlet.backgroundColor = UIColor.white
        bDayOutlet.setValue(UIColor.black, forKeyPath: "textColor")
        bDayOutlet.setValue(1.0, forKeyPath: "alpha")
        bDayOutlet.setDate( dateFromArray(arr: thisEmployee.birthday), animated: true)
        
        stDayOutlet.backgroundColor = UIColor.white
        stDayOutlet.setValue(UIColor.black, forKeyPath: "textColor")
        stDayOutlet.setValue(1.0, forKeyPath: "alpha")
        stDayOutlet.setDate( dateFromArray(arr: thisEmployee.started), animated: true)
        stDayOutlet.maximumDate = dateFromArray(arr: dateArray.today)
        
        UIApplication.shared.statusBarStyle = .default


    }
    
    
    func showCalculatedAnswer() {
        
        let fancyText = calculateRetirement()
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
    
    func popupInfo() {
        
        var version = ""
        
        if let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version = v
        }
        
        
        let alert = UIAlertController(title: "80 Points V\(version)", message: "An app by David Levy to calculate Arizona State Retirement eligibility based on the information provided on the official ASRS website. THIS IS NOT AN OFFICIAL ASRS TOOL, and any calculations or estimations provided here should be verified with your Human Resources department and official resources. ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }



}

