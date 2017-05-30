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
    
    dateArray.floating = thisEmployee.started
    thisEmployee.age = inferAgeWhenStarted()
    thisEmployee.yearsWorked = 0
    thisEmployee.points = thisEmployee.age
    thisEmployee.eligible = false
    
}

func printEmployeeData () {
    print("\(thisEmployee.age) yrs old, \(thisEmployee.yearsWorked) yrs worked, \(thisEmployee.points) points earned.")
}

func inferAgeWhenStarted() -> Int {
    var answer = 0
    let startDate = dateFromArray(arr: thisEmployee.started)
    let bDate = dateFromArray(arr: thisEmployee.birthday)
    answer = yearDifference(from: bDate, to: startDate)
    return answer
}


func inferYearsWorked() -> Int {
    let startDate = dateFromArray(arr: thisEmployee.started)
    let today = dateFromArray(arr: dateArray.today)
    let yearsWorked = yearDifference(from: startDate, to: today)
    return yearsWorked
}


func oldEnoughToWork() -> Bool {
    if thisEmployee.age < 14 {
        return false
    } else {
        return true
    }
}

func checkIfBirthdayBeforeStartDate () {
    if thisEmployee.birthday[0] < thisEmployee.started[0] {
        thisEmployee.birthdayFirst = true
    } else if thisEmployee.birthday[0] == thisEmployee.started[0] {
        if thisEmployee.birthday[1] < thisEmployee.started[1] {
            thisEmployee.birthdayFirst = true
        }
    }
}


func getBirthdayPoint () {
    dateArray.printableString = thisDateString(isBDay: true)
    thisEmployee.age = thisEmployee.age + 1
    addPoint()
}


func getWorkAnniversaryPoint() {
    dateArray.printableString = thisDateString(isBDay: false)
    thisEmployee.yearsWorked = thisEmployee.yearsWorked + 1
    addPoint()
}


func addPoint() {
    thisEmployee.points = thisEmployee.points + 1
}


func thisDateString(isBDay:Bool) -> String {
    var answer = ""
    if isBDay {
        answer = "\(thisEmployee.birthday[0])-\(thisEmployee.birthday[1])-\(dateArray.floating[2])"
        dateArray.printable = [thisEmployee.birthday[0],thisEmployee.birthday[1],dateArray.floating[2]]
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


func getPoints() {
    
    if thisEmployee.birthdayFirst {
        
        getBirthdayPoint()
        checkEligibility()
        
        if !thisEmployee.eligible {
            getWorkAnniversaryPoint()
            checkEligibility()
        }
        
    } else {
        
        getWorkAnniversaryPoint()
        checkEligibility()
        
        if !thisEmployee.eligible {
            getBirthdayPoint()
            checkEligibility()
        }
    }
}




func calculateRetirement () -> (title: String, body: String)  {
    
    checkIfBirthdayBeforeStartDate()
    
    //start counting until eligible..
    while !thisEmployee.eligible {
        getPoints()
        addYear()
    }
    
    // now format an answer
    let finalDate = dateFromArray(arr: dateArray.printable)
    let startDate = dateFromArray(arr: thisEmployee.started)
    let today = dateFromArray(arr: dateArray.today)
    let daysFromToday = dayDifference(from: today, to: finalDate)
    let yearsFromToday = yearDifference(from: today, to: finalDate)
    let yearsFromStartToToday = yearDifference(from: startDate, to: today)

    var titleText = "Calculated!"
    
    if daysFromToday <= 0 {
        titleText = "Congratulations! You are eligible!"
    } else if daysFromToday < 365 {
        titleText = "Boom! Less than 1 year left!"
    } else if yearsFromToday <= 2 {
        titleText = "Whoa! Victory is near!"
    } else if yearsFromToday <= 5 {
        titleText = "Wow! The goal in sight!"
    } else if yearsFromToday < 10 {
        titleText = "Awesome! Getting close!"
    } else if yearsFromToday <= 14 {
        titleText = "Doing great!"
    } else if yearsFromToday <= 18 {
        titleText = "Keep trucking!"
    } else {
        titleText = "Hunker down!"
    }
    
    let bodyText = ("Eligible to retire after working \(thisEmployee.yearsWorked) years at age \(thisEmployee.age) on \(dateArray.printableString). That is in \(yearsFromToday) years or \(daysFromToday) days from now. If you are still employed, you now have been employed \(yearsFromStartToToday) years. \n\n\(thisEmployee.reasonEligible)"
    )
    
    return (titleText,bodyText)
}


func inferBatch (hireDate:Date) -> Batch {
    
    if hireDate < BatchData.firstBefore {
        return Batch.first
    } else if hireDate < BatchData.secondBefore {
        return Batch.second
    } else {
        return Batch.third
    }
}


func batchText (b:Batch) -> String {
    
    switch b {
    case Batch.first:
        return "\(BatchData.firstText)"
    case Batch.second:
        return "\(BatchData.secondText)"
    case Batch.third:
        return "\(BatchData.thirdText)"
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




