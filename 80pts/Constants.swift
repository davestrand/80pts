//
//  Constants.swift
//  80pts
//
//  Created by Levy,David A. on 6/6/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import Foundation

class Defaults {
    
    static let group = UserDefaults(suiteName: "group.com.hobjoblin.80pts")

    
}

class Text {
    
    static let createNew = "+ Create New +"
    static let noName = "..."
}

class Key {
    
    static let currentEmployee = "CurrentEmployee"
    static let people = "People"
    
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
