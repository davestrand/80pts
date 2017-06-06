//
//  Person.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation

//protocol Employee {
//    var birthday: [Int] { get }
//    var started: [Int] { get }
//    var age:Int { get }
//    var points:Int { get }
//    var yearsWorked:Int { get }
//    var birthdayFirst:Bool { get }
//    var pointsNeededToRetire:Int { get }
//    var batch:Batch { get }
//    var eligible:Bool { get }
//    var reasonEligible:String { get }
//}

class Person: NSObject, NSCoding {
    
    var name: String
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
    

    init(name: String, birthday: [Int], started: [Int], age: Int, points: Int, yearsWorked: Int, birthdayFirst: Bool, pointsNeededToRetire: Int, batch: Int, eligible: Bool, reasonEligible: String) {
        
        self.name = name
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
        
    }
    
    required init (coder aDecoder: NSCoder) {
        
        Person.registerClassName()
        
        self.name = aDecoder.decodeObject(forKey: "name") as! String
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
        print("decoded data")

        
    }
    
    func encode(with aCoder: NSCoder) {
        
        Person.registerClassName()
        
        aCoder.encode(name, forKey: "name")
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
        print("encoded data")
        
    }
    
    
    
}



var thisEmployee = Person(name: "David Levy",
                          birthday: [10,20,1974],
                          started: [1,5,2005],
                          age: 0,
                          points: 0,
                          yearsWorked: 0,
                          birthdayFirst: false,
                          pointsNeededToRetire: 80,
                          batch: 3,
                          eligible: false,
                          reasonEligible: "Not yet eligible."
)


//This is added because the extension wasn't properly reading my custom Person class.
//https://stackoverflow.com/questions/43864708/nskeyedunarchiver-unarchiveobject-fails-with-an-error-when-picking-data-from-use
extension NSCoding {
    static func registerClassName() {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)
    }
}

