//
//  Date.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation

var dateArray = DateArray(today: [0,0,0], floating: [0,0,0], printable: [0,0,0], printableString: "")

protocol Data {
    var today: [Int] { get }
    var floating: [Int] { get }
    var printable: [Int] { get }
    var printableString: String { get }
}


struct DateArray: Data {
    var today: [Int]
    var floating: [Int]
    var printable: [Int]
    var printableString: String
    
}


struct Dates {
    
    static func dateFromArray(arr:[Int]) -> Date {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let components = NSDateComponents()
        components.month = arr[0]
        components.day = arr[1]
        components.year = arr[2]
        let date = calendar?.date(from: components as DateComponents)
        return date!
    }
    
    static func setTodaysDate () -> [Int] {
        let date = NSDate()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: date as Date)
        let day = components.day
        let month = components.month
        let year = components.year
        return [month!, day!, year!]
    }
    
    static func dayDifference(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: from, to: to)
        return components.day!
    }
    
    static func monthDifference(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month], from: from, to: to)
        return components.month!
    }
    
    static func yearDifference(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.year], from: from, to: to)
        return components.year!
    }
    
}
