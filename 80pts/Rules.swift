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
    
    static let firstBefore = dateFromArray(arr: [1,1,1984]) // if before 84
    static let secondBefore = dateFromArray(arr: [6,30,2011]) // else if before 11
    // else you are third batch
    
    static let firstText = "Since your start date was prior to January 1, 1984 your Average Monthly Compensation is calculated by taking the highest consecutive 60 months of contributions within the last 120 months of contributions reported to the ASRS, which could span more than 10 calendar years. Payments made as a result of termination of employment (Termination Pay) such as vacation/annual leave, sick leave, termination incentive payments, etc., are included in the calculation, with exceptions."
    
    static let secondText = "Since your start date was between January 1, 1984 and June 30, 2011 your Average Monthly Compensation is calculated by taking the highest consecutive 36 months of contributions within the last 120 months of contributions reported to the ASRS, which could span more than 10 calendar years. Termination Pay is excluded."
    
    static let thirdText = "Since your start date was after June 30, 2011 your Average Monthly Compensation is calculated by taking the highest consecutive 60 months of contributions within the last 120 months of contributions reported to the ASRS, which could span more than 10 calendar years. Termination pay is excluded."
    
}



func checkEligibility (person:Person) {
    
    if person.points >= person.pointsNeededToRetire {
            person.reasonEligible = "Reason: 80 points and at least 5 years."
            
            if person.yearsWorked >= person.wageYearsRequired {
                person.eligible = true
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




