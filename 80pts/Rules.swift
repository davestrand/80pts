//
//  Rules.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//

//ASRS Rules depend on the year you started.
//https://www.azasrs.gov/content/retirement-eligibility



enum Batch : Int {
    case first = 1  // Prior to 1/1/1984
    case second = 2 // 1/1/1984 through 6/30/2011
    case third = 3 // 7/1/2011 or later
}


struct BatchData {
    
    static let firstBefore = Dates.dateFromArray(arr: [1,1,1984]) // if before 84
    static let secondBefore = Dates.dateFromArray(arr: [6,30,2011]) // else if before 11
    // else you are third batch
    
}


