//
//  Calculations.swift
//  80pts
//
//  Created by Levy,David A. on 12/21/16.
//  Copyright © 2016 mcc. All rights reserved.
//

import Foundation


func dateFromArray(arr:[Int]) -> Date {
    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
    let components = NSDateComponents()
    components.month = arr[0]
    components.day = arr[1]
    components.year = arr[2]
    let date = calendar?.date(from: components as DateComponents)
    return date!
}

func setTodaysDate () -> [Int] {
    let date = NSDate()
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: date as Date)
    let day = components.day
    let month = components.month
    let year = components.year
    return [month!, day!, year!]
}

func dayDifference(from: Date, to: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([Calendar.Component.day], from: from, to: to)
    return components.day!
}

func monthDifference(from: Date, to: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([Calendar.Component.month], from: from, to: to)
    return components.month!
}

func yearDifference(from: Date, to: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([Calendar.Component.year], from: from, to: to)
    return components.year!
}



func setupData () {

    dateArray.today = setTodaysDate()
    dateArray.floating = selectedEmployee.started
    
    selectedEmployee.age = inferAgeWhenStarted(person: selectedEmployee)
    selectedEmployee.yearsWorked = 0
    selectedEmployee.points = selectedEmployee.age
    selectedEmployee.eligible = false
    
    
}

func printEmployeeData (person:Person) {
    print("\(person.age) yrs old, \(person.yearsWorked) yrs worked, \(person.points) points earned.")
}

func inferAgeWhenStarted(person:Person) -> Int {
    var answer = 0
    let startDate = dateFromArray(arr: person.started)
    let bDate = dateFromArray(arr: person.birthday)
    answer = yearDifference(from: bDate, to: startDate)
    return answer
}


func inferYearsWorked(person:Person) -> Int {
    let startDate = dateFromArray(arr: person.started)
    let today = dateFromArray(arr: dateArray.today)
    let yearsWorked = yearDifference(from: startDate, to: today)
    return yearsWorked
}


func oldEnoughToWork(person:Person) -> Bool {
    if person.age < 14 {
        return false
    } else {
        return true
    }
}

func checkIfBirthdayBeforeStartDate (person:Person ) {
    if person.birthday[0] < person.started[0] {
        person.birthdayFirst = true
    } else if person.birthday[0] == person.started[0] {
        if person.birthday[1] < person.started[1] {
            person.birthdayFirst = true
        }
    }
}


func getBirthdayPoint (person:Person) {
    dateArray.printableString = thisDateString(person: person, isBDay: true)
    person.age = person.age + 1
    addPoint(person: person)
}


func getWorkAnniversaryPoint(person:Person ) {
    dateArray.printableString = thisDateString(person: person, isBDay: false)
    person.yearsWorked = person.yearsWorked + 1
    addPoint(person: person)
}


func addPoint(person:Person) {
    person.points = person.points + 1
}


func thisDateString(person:Person, isBDay:Bool) -> String {
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


func addYear() {
    let thisYear = dateArray.floating[2]
    let newYear = thisYear + 1
    dateArray.floating.insert(newYear, at: 2)
}


func getPoints(person:Person) {
    
    if person.birthdayFirst {
        
        getBirthdayPoint(person: person)
        checkEligibility(person: person)
        
        if !person.eligible {
            getWorkAnniversaryPoint(person: person)
            checkEligibility(person: person)
        }
        
    } else {
        
        getWorkAnniversaryPoint(person: person)
        checkEligibility(person: person)
        
        if !person.eligible {
            getBirthdayPoint(person: person)
            checkEligibility(person: person)
        }
    }
}




func calculateRetirement (person:Person, longForm: Bool) -> (title: String, body: String)  {
    
    checkIfBirthdayBeforeStartDate(person:person)
    
    //start counting until eligible..
    while !person.eligible {
        getPoints(person: person)
        addYear()
    }
    
    // now format an answer
    let finalDate = dateFromArray(arr: dateArray.printable)
    let startDate = dateFromArray(arr: person.started)
    let today = dateFromArray(arr: dateArray.today)
    let daysFromToday = dayDifference(from: today, to: finalDate)
    let yearsFromToday = yearDifference(from: today, to: finalDate)
    let yearsFromStartToToday = yearDifference(from: startDate, to: today)

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
    
        
     bodyText = ("\(person.name) is eligible to retire after working \(person.yearsWorked) years at age \(person.age) on \(dateArray.printableString). That is in \(yearsFromToday) years or \(daysFromToday) days from now. If you are still employed, you now have been employed \(yearsFromStartToToday) years. \n\n\(person.reasonEligible)"
    )
        
    } else {
        
        bodyText = ("Can retire on \(dateArray.printableString) in \(yearsFromToday) years or \(daysFromToday) days from now.")
        
    }
    
    return (titleText,bodyText)
}


func inferBatch (hireDate:Date) -> Int {
    
    if hireDate < BatchData.firstBefore {
        return Batch.first.rawValue
    } else if hireDate < BatchData.secondBefore {
        return Batch.second.rawValue
    } else {
        return Batch.third.rawValue
    }
}


func batchText (b:Int) -> String {
    
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

func calculateMonthlyCompensation (i:Int) -> String {
    
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




