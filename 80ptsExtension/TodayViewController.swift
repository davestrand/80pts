//
//  TodayViewController.swift
//  80ptsExtension
//
//  Created by Levy,David A. on 6/1/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var widgetTimeLabel: UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        let defaults = UserDefaults.standard

        widgetTimeLabel?.text = "Not yet assigned."
        
        if let employeeData = defaults.data(forKey: "currentEmployee") {

            let personData:Person = NSKeyedUnarchiver.unarchiveObject(with: employeeData ) as! Person
            
            print(personData.age)
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
