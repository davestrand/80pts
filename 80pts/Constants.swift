//
//  Constants.swift
//  80pts
//
//  Created by Levy,David A. on 6/6/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import Foundation
import UIKit


class Defaults {
    
    static let group = UserDefaults(suiteName: "group.com.hobjoblin.80pts")

    
}

class Text {
    
    static let createNew = "+ Create New +"
    static let noName = "..."
    static let ageAlert1 = "You were"
    static let ageAlert2 = "years old when you started working? That can't be right."
}

class Key {
    
    static let currentEmployee = "CurrentEmployee"
    static let people = "People"
    
}

struct Colors {
    //https://www.ralfebert.de/snippets/ios/swift-uicolor-picker/
    
    static let brightnessRange = 40
    
    
    static let cellBackgroundNormal = UIColor(hue: 205/360, saturation: 100/100, brightness: 50/100, alpha: 1.0)

    static let cellBackgroundSelected = UIColor(hue: 205/360, saturation: 100/100, brightness: 80/100, alpha: 1.0)

    static let cellBackgroundCreateNew = UIColor(hue: 205/360, saturation: 20/100, brightness: 20/100, alpha: 1.0)
    
    static let cellBackgroundPressHighlight = UIColor(hue: 205/360, saturation: 100/100, brightness: 50/100, alpha: 1.0)

    
}

struct WageOption {
         var years: Int = 0
         var percent: Double = 0.0
         var multiplier: Double = 0.0
}

class Wage {
    
    static func setWage (years:Int, percent:Double, multiplier:Double) -> WageOption {
        var option = WageOption()
        option.years = years
        option.percent = percent
        option.multiplier = multiplier
        return option
    }

    
    
    
    static let options = [
        setWage(years:5,percent:10.50,multiplier:2.10),
        setWage(years:10,percent:21.00,multiplier:2.10),
        setWage(years:15,percent:31.50,multiplier:2.10),
        setWage(years:20,percent:43.00,multiplier:2.15),
        setWage(years:23,percent:49.45,multiplier:2.15),
        setWage(years:25,percent:55.00,multiplier:2.20),
        setWage(years:27,percent:59.40,multiplier:2.20),
        setWage(years:30,percent:69.00,multiplier:2.30),
        setWage(years:32,percent:73.60,multiplier:2.30)
        
    ]
    
    
    
}
