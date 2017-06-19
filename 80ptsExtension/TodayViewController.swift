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
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var bodyLabel: UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()


        Defaults.group?.synchronize()
        Person.registerClassName()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
      
        var bodyText = ""
        var titleText = ""
        titleLabel?.text = titleText
        bodyLabel?.text = bodyText
        
        if let data =  Defaults.group?.data(forKey: Key.currentEmployee), let lastPersonChecked = NSKeyedUnarchiver.unarchiveObject(with: data) as? Person {
            
            Helper.setAsSelected(thisPerson: lastPersonChecked)
            
            if Determine.oldEnoughToWork(person: lastPersonChecked) {
                let answer = Determine.retirement(person: lastPersonChecked, longForm: false)
                bodyText = answer.body
                titleText = answer.title
            } else {
                bodyText = "\(Text.ageAlert1) \(lastPersonChecked.age) \(Text.ageAlert2)"
            }

                titleLabel?.text = titleText
                bodyLabel?.text = bodyText
            
        } else {
            
            bodyLabel?.text = "Oops!  \(NCUpdateResult.noData)"
            // If an error is encountered, use NCUpdateResult.Failed
            // If there's no update required, use NCUpdateResult.NoData
            // If there's an update, use NCUpdateResult.NewData
        }

        completionHandler(NCUpdateResult.newData)
    }
    
}
