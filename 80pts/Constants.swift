//
//  Constants.swift
//  80pts
//
//  Created by Levy,David A. on 6/6/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit


struct Defaults {
    
    static let group = UserDefaults(suiteName: "group.com.hobjoblin.80pts")

}

struct Text {
    
    static let createNew = "+ Create New +"
    static let noName = "..."
    static let ageAlert1 = "You were"
    static let ageAlert2 = "years old when you started working? That can't be right."
    static let saveAndExit = "Save and Exit"
    static let linksBody = "Here are some links to official ASRS web pages."
    static let linksTitle = "Official ASRS Webpages"
    static let linkBenefits = "Estimate Benefits"
    static let linkEligibility = "Retirement Eligibility"
    static let notYetEligible = "Not yet eligible."
    static let ok = "OK"
    static let howMuch = "How Much?"
    
    static let infoTitle = "80 Points V"
    static let infoBody = "An app by David Levy to calculate Arizona State Retirement eligibility based on the information provided on the official ASRS website. THIS IS NOT AN OFFICIAL ASRS TOOL, and any calculations or estimations provided here should be verified with your Human Resources department and official resources."
    
    static let ageWarnTitle = "Hmm."
    static let ageWarnBody1 = "Your starting age is"
    static let ageWarnBody2 = "which is not old enough to work in Arizona.  Please check both dates to be sure they are accurate."
    
    static let ratesBody1 = "After working "
    static let ratesBody2 = " years your Percentage of Average Monthly Compensation would likely be "
    static let ratesBody3 = ".  Remember, more Service Credits = higher percentage paid. \n5 = 10.50%\n10 = 21.00%\n15 = 31.50%\n20 = 43.00%\n23 = 49.45%\n25 = 55.00%\n27 = 59.40%\n30 = 69.00%\n32 = 73.60%\n\n"

    
    
}

struct Key {
    
    static let currentEmployee = "CurrentEmployee"
    static let people = "People"
    static let urlBenefits = "https://www.azasrs.gov/content/estimate-your-benefits"
    static let urlEligibility = "https://www.azasrs.gov/content/retirement-eligibility"
    
}

struct Colors {
    //https://www.ralfebert.de/snippets/ios/swift-uicolor-picker/
    
    static let brightnessRange = 40
    static let cellBackgroundNormal = UIColor(hue: 205/360, saturation: 100/100, brightness: 50/100, alpha: 1.0)
    static let cellBackgroundSelected = UIColor(hue: 205/360, saturation: 100/100, brightness: 80/100, alpha: 1.0)
    static let cellBackgroundCreateNew = UIColor(hue: 205/360, saturation: 20/100, brightness: 20/100, alpha: 1.0)
    static let cellBackgroundPressHighlight = UIColor(hue: 205/360, saturation: 100/100, brightness: 50/100, alpha: 1.0)
    
}
