//
//  SelectedPerson.swift
//  80pts
//
//  Created by Levy,David A. on 6/22/17.
//  Copyright © 2017 mcc. All rights reserved.
//



struct Selected {
    
    static var id = ""
    
    static var person = Person(name: "David Levy",
                               uid: "unassigned",
                               birthday: [10,20,1974],
                               started: [1,5,2005],
                               age: 0,
                               points: 0,
                               yearsWorked: 0,
                               birthdayFirst: false,
                               pointsNeededToRetire: 80,
                               batch: 3,
                               eligible: false,
                               reasonEligible: "Not yet eligible.",
                               percentOfWages: 55.00,
                               wageMultiplier: 2.20,
                               wageYearsRequired: 25
    )
    
}


