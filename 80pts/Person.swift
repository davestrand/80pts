//
//  Person.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation

protocol Employee {
    var birthday: [Int] { get }
    var started: [Int] { get }
    var age:Int { get }
    var points:Int { get }
    var yearsWorked:Int { get }
    var birthdayFirst:Bool { get }
    var pointsNeededToRetire:Int { get }
    var batch:Batch { get }
    var eligible:Bool { get }
    var reasonEligible:String { get }
}

struct Person: Employee {
    var birthday: [Int]
    var started: [Int]
    var age: Int
    var points: Int
    var yearsWorked:Int
    var birthdayFirst:Bool
    var pointsNeededToRetire:Int
    var batch:Batch
    var eligible:Bool
    var reasonEligible:String
}


var thisEmployee = Person(birthday: [10,20,1974],
                          started: [1,5,2005],
                          age: 0,
                          points: 0,
                          yearsWorked: 0,
                          birthdayFirst:false,
                          pointsNeededToRetire:80,
                          batch:Batch.third,
                          eligible:false,
                          reasonEligible:"Not yet eligible."
)


