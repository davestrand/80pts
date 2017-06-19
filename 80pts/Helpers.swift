//
//  Helpers.swift
//  80pts
//
//  Created by Levy,David A. on 6/8/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import UIKit


extension String {
    
    
    var length : Int {
        return self.characters.count
    }
    
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



