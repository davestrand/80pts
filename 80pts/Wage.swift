//
//  Wage.swift
//  80pts
//
//  Created by Levy,David A. on 6/22/17.
//  Copyright © 2017 mcc. All rights reserved.
//



struct WageOption {
    var years: Int = 0
    var percent: Double = 0.0
    var multiplier: Double = 0.0
}

struct Wage {
    
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
