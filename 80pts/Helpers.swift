//
//  Helpers.swift
//  80pts
//
//  Created by Levy,David A. on 6/8/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit


extension String {
    
    func digitsOnly() -> String{
        let stringArray = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")
        return newString
    }
    
    func charsOnly() -> String{
        let stringArray = self.components(separatedBy: NSCharacterSet.letters.inverted)
        let newString = stringArray.joined(separator: "")
        return newString
    }
}


struct Helper {
    
    //Exposed for Today Widget...
    static func setAsSelected(thisPerson: Person) {
        Selected.person = thisPerson
        Selected.id = thisPerson.name //for highlight of selected person
        dateArray.today = Dates.setTodaysDate()
        dateArray.floating = Selected.person.started
        Selected.person.age = Determine.ageWhenStarted(person: Selected.person)
        Selected.person.yearsWorked = 0
        Selected.person.points = Selected.person.age
        Selected.person.eligible = false
    }
    
    static func initializeDates (thisPerson: Person) {
        dateArray.today = Dates.setTodaysDate()
        dateArray.floating = thisPerson.started
    }
    
    
    static func persistSelectedEmployee (person:Person ) {
        //https://grokswift.com/notification-center-widget/
         
        //OLDWAY
        //let encodedData = NSKeyedArchiver.archivedData(withRootObject: person)
        
        //NEW WAY
        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)

        
        
        
        
        if let defaultGroup = Defaults.group {
            defaultGroup.set(encodedData, forKey: Key.currentEmployee)
            defaultGroup.synchronize()
        }
    }
}


//Added because the extension wasn't properly reading my custom Person class.
//https://stackoverflow.com/questions/43864708/nskeyedunarchiver-unarchiveobject-fails-with-an-error-when-picking-data-from-use
extension NSCoding {
    static func registerClassName() {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)
    }
}

