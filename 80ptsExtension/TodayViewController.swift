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

        widgetTimeLabel?.text = "Not yet assigned."
        
        
    
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

        Defaults.group?.synchronize()
        Person.registerClassName()
        
        if let data =  Defaults.group?.data(forKey: Key.currentEmployee) {
            print("I have found some data \(data)")
            widgetTimeLabel?.text = "found some data"
            

            
            if let aPerson = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
                widgetTimeLabel?.text = aPerson.name

            } else   {
                widgetTimeLabel?.text = "found some data but can't make it into a person"

            }
            

        } else {
            print("not the data you are looking for")
            widgetTimeLabel?.text = "Test failed."

        }

        
//        if let testData = Defaults.group?.string(forKey: "TEST") {
//            widgetTimeLabel?.text = testData
//
//        } else {
//            widgetTimeLabel?.text = "Test failed."
//
//        }
        
        //GROUP DATA SAVING BUT THIS DOESN"T WORK YET...
//        if let data =  Defaults.group?.data(forKey: Key.currentEmployee), let aPerson = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
//            print("\(aPerson.name) is currently stored in group data as primary person.")
//            widgetTimeLabel?.text = aPerson.name
//            
//        } else {
//            print("There is a problem loading group data")
//            widgetTimeLabel?.text = "There was a problem loading profile."
//            
//        }
        
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
