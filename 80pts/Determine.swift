//
//  Calculations.swift
//  80pts
//
//  Created by Levy,David A. on 12/21/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation



struct Determine {
    
    static func ageWhenStarted(person:Person) -> Int {
        var answer = 0
        let startDate = Dates.dateFromArray(arr: person.started)
        let bDate = Dates.dateFromArray(arr: person.birthday)
        answer = Dates.yearDifference(from: bDate, to: startDate)
        return answer
    }
    
    static func oldEnoughToWork(person:Person) -> Bool {
        if person.age < 14 {
            return false
        } else {
            return true
        }
    }
    
    static func ifBirthdayIsBeforeStartDate (person:Person ) {
        if person.birthday[0] < person.started[0] {
            person.birthdayFirst = true
        } else if person.birthday[0] == person.started[0] {
            if person.birthday[1] < person.started[1] {
                person.birthdayFirst = true
            }
        }
    }
    
    static func dateString(person:Person, isBDay:Bool) -> String {
        var answer = ""
        if isBDay {
            answer = "\(person.birthday[0])-\(person.birthday[1])-\(dateArray.floating[2])"
            dateArray.printable = [person.birthday[0],person.birthday[1],dateArray.floating[2]]
        } else {
            answer = "\(dateArray.floating[0])-\(dateArray.floating[1])-\(dateArray.floating[2])"
            dateArray.printable = [dateArray.floating[0],dateArray.floating[1],dateArray.floating[2]]
        }
        return answer
    }
    
    
    static func retirement (person:Person, longForm: Bool) -> (title: String, body: String)  {
        
        ifBirthdayIsBeforeStartDate(person:person)
        
        //start counting until eligible..
        while !person.eligible {
            getPoints(person: person)
            addYear()
        }
        
        // now format an answer
        let finalDate = Dates.dateFromArray(arr: dateArray.printable)
        let startDate = Dates.dateFromArray(arr: person.started)
        let today = Dates.dateFromArray(arr: dateArray.today)
        let daysFromToday = Dates.dayDifference(from: today, to: finalDate)
        let yearsFromToday = Dates.yearDifference(from: today, to: finalDate)
        let yearsFromStartToToday = Dates.yearDifference(from: startDate, to: today)
        
        var titleText = "Calculated!"
        
        if daysFromToday <= 0 {
            titleText = "Congratulations \(person.name)! You are eligible!"
        } else if daysFromToday < 365 {
            titleText = "Boom! Less than 1 year left \(person.name)!"
        } else if yearsFromToday <= 2 {
            titleText = "Whoa! Victory is near \(person.name)!"
        } else if yearsFromToday <= 5 {
            titleText = "Wow! The goal in sight \(person.name)!"
        } else if yearsFromToday < 10 {
            titleText = "Awesome! Getting close \(person.name)!"
        } else if yearsFromToday <= 14 {
            titleText = "Doing great \(person.name)!"
        } else if yearsFromToday <= 18 {
            titleText = "Keep trucking \(person.name)!"
        } else {
            titleText = "Hunker down \(person.name)!"
        }
        
    
        var bodyText = ""
        
        if longForm {
    
            bodyText = ("\(person.name) is eligible to retire at \(person.percentOfWages)% of wages after working \(person.yearsWorked) years at age \(person.age) on \(dateArray.printableString). That is in \(yearsFromToday) years or \(daysFromToday) days from now. If you are still employed, you now have been employed \(yearsFromStartToToday) years. \n\n\(person.reasonEligible)"
            )
            
        } else {
            
            bodyText = ("Can retire on \(dateArray.printableString) at \(person.percentOfWages)% of wages in \(yearsFromToday) years or \(daysFromToday) days from now.")
            
        }
        return (titleText,bodyText)
    }
    
    
    static func batch (hireDate:Date) -> Int {
        
        if hireDate < BatchData.firstBefore {
            return Batch.first.rawValue
        } else if hireDate < BatchData.secondBefore {
            return Batch.second.rawValue
        } else {
            return Batch.third.rawValue
        }
    }
    
    static func batchText (b:Int) -> String {
        
        switch b {
        case Batch.first.rawValue:
            return "\(BatchData.firstText)"
        case Batch.second.rawValue:
            return "\(BatchData.secondText)"
        case Batch.third.rawValue:
            return "\(BatchData.thirdText)"
        default:
            return "Batch Unknown"
        }
    }
    
    static func wageIndex (person:Person) -> Double {
        var answer = 0.0
        for i in 0...Wage.options.count - 1 {
            
            let thisPercent = Wage.options[i].percent
            
            if thisPercent == person.percentOfWages {
                answer = Double(i)
            }
        }
        
        return answer
    }
    
    
    static func wagePercentage (stepperIndex:Double) -> WageOption {
        
        let index = Int(stepperIndex)
        let newOption = Wage.options[index]
        return newOption
    }
    
    static func monthlyCompensation (i:Int) -> String {
        
        if i < 5 {
            return "0.0%"
        } else if i < 10 {
            return "10.50%"
        } else if i < 15 {
            return "21.00%"
        } else if i < 20 {
            return "31.50%"
        } else if i < 23 {
            return "43.00%"
        } else if i < 25 {
            return "49.45%"
        } else if i < 27 {
            return "55.00%"
        } else if i < 30 {
            return "59.40%"
        } else if i < 32 {
            return "69.00%"
        } else {
            return "73.60%"
        }
    }
    
    
    static func eligibility (person:Person) {
        
        if person.points >= person.pointsNeededToRetire {
            if person.yearsWorked >= 5 {
                
                person.reasonEligible = "Reason: 80 points and at least 5 years."
                
                if person.yearsWorked >= person.wageYearsRequired {
                    person.eligible = true
                }
            }
        }
        
        if person.age >= 65 {
            if person.batch == Batch.third.rawValue {
                if person.yearsWorked >= 10 {
                    person.reasonEligible = "Reason: 65 points and at least 10 years."
                    if person.yearsWorked >= person.wageYearsRequired {
                        person.eligible = true
                    }
                }
            } else {
                person.reasonEligible = "Reason: 65 points and at least 5 years."
                if person.yearsWorked >= person.wageYearsRequired {
                    person.eligible = true
                }
            }
        } else if person.age >= 62 {
            if person.yearsWorked >= 10 {
                person.reasonEligible = "Reason: 62 points and at least 10 years."
                if person.yearsWorked >= person.wageYearsRequired {
                    person.eligible = true
                }
            }
        } else if person.age >= 60 {
            if person.yearsWorked >= 25 {
                if person.batch == Batch.third.rawValue {
                    person.reasonEligible = "Reason: 60 points and at least 25 years."
                    if person.yearsWorked >= person.wageYearsRequired {
                        person.eligible = true
                    }
                }
            }
        } else if person.age >= 55 {
            if person.yearsWorked >= 30 {
                if person.batch == Batch.third.rawValue {
                    person.reasonEligible = "Reason: 55 points and at least 30 years."
                    if person.yearsWorked >= person.wageYearsRequired {
                        person.eligible = true
                    }
                }
            }
        }
    }
}





extension Determine {
    
    static func getBirthdayPoint (person:Person) {
        dateArray.printableString = dateString(person: person, isBDay: true)
        person.age = person.age + 1
        addPoint(person: person)
    }
    
    static func getWorkAnniversaryPoint(person:Person ) {
        dateArray.printableString = dateString(person: person, isBDay: false)
        person.yearsWorked = person.yearsWorked + 1
        addPoint(person: person)
    }
    
    static func addPoint(person:Person) {
        person.points = person.points + 1
    }

    static func addYear() {
        let thisYear = dateArray.floating[2]
        let newYear = thisYear + 1
        dateArray.floating.insert(newYear, at: 2)
    }
    
    static func getPoints(person:Person) {
        if person.birthdayFirst {
            getBirthdayPoint(person: person)
            eligibility(person: person)
            if !person.eligible {
                getWorkAnniversaryPoint(person: person)
                eligibility(person: person)
            }
        } else {
            getWorkAnniversaryPoint(person: person)
            eligibility(person: person)
            if !person.eligible {
                getBirthdayPoint(person: person)
                eligibility(person: person)
            }
        }
    }
}










