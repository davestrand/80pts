//
//  Person.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
    
    var name: String
    var uid: String
    var birthday: [Int]
    var started: [Int]
    var age: Int
    var points: Int
    var yearsWorked: Int
    var birthdayFirst: Bool
    var pointsNeededToRetire: Int
    var batch: Int
    var eligible: Bool
    var reasonEligible: String
    var percentOfWages: Double
    var wageMultiplier: Double
    var wageYearsRequired: Int
    
    

    init(name: String, uid: String, birthday: [Int], started: [Int], age: Int, points: Int, yearsWorked: Int, birthdayFirst: Bool, pointsNeededToRetire: Int, batch: Int, eligible: Bool, reasonEligible: String, percentOfWages: Double, wageMultiplier: Double, wageYearsRequired: Int) {
        
        self.name = name
        self.uid = uid
        self.birthday = birthday
        self.started = started
        self.age = age
        self.points = points
        self.yearsWorked = yearsWorked
        self.birthdayFirst = birthdayFirst
        self.pointsNeededToRetire = pointsNeededToRetire
        self.batch = batch
        self.eligible = eligible
        self.reasonEligible = reasonEligible
        self.percentOfWages = percentOfWages
        self.wageMultiplier = wageMultiplier
        self.wageYearsRequired = wageYearsRequired
        
    }
    
    required init (coder aDecoder: NSCoder) {
        
        Person.registerClassName()
        
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.uid = aDecoder.decodeObject(forKey: "uid") as! String
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as! [Int]
        self.started = aDecoder.decodeObject(forKey: "started") as! [Int]
        self.age = aDecoder.decodeInteger(forKey: "age")
        self.points = aDecoder.decodeInteger(forKey: "points")
        self.yearsWorked = aDecoder.decodeInteger(forKey: "yearsWorked")
        self.birthdayFirst = aDecoder.decodeBool(forKey: "birthdayFirst")
        self.pointsNeededToRetire = aDecoder.decodeInteger(forKey: "pointsNeededToRetire")
        self.batch = aDecoder.decodeInteger(forKey: "batch")
        self.eligible = aDecoder.decodeBool(forKey: "eligible")
        self.reasonEligible = aDecoder.decodeObject(forKey: "reasonEligible") as! String
        self.percentOfWages = aDecoder.decodeDouble(forKey: "percentOfWages")
        self.wageMultiplier = aDecoder.decodeDouble(forKey: "wageMultiplier")
        self.wageYearsRequired = aDecoder.decodeInteger(forKey: "wageYearsRequired")
    }
    
    func encode(with aCoder: NSCoder) {
        
        Person.registerClassName()
                
        aCoder.encode(name, forKey: "name")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(started, forKey: "started")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(points, forKey: "points")
        aCoder.encode(yearsWorked, forKey: "yearsWorked")
        aCoder.encode(birthdayFirst, forKey: "birthdayFirst")
        aCoder.encode(pointsNeededToRetire, forKey: "pointsNeededToRetire")
        aCoder.encode(batch, forKey: "batch")
        aCoder.encode(eligible, forKey: "eligible")
        aCoder.encode(reasonEligible, forKey: "reasonEligible")
        aCoder.encode(percentOfWages, forKey: "percentOfWages")
        aCoder.encode(wageMultiplier, forKey: "wageMultiplier")
        aCoder.encode(wageYearsRequired, forKey: "wageYearsRequired")
        
    }
    
    
    
}





