//
//  People.swift
//  80pts
//
//  Created by Levy,David A. on 6/6/17.
//  Copyright © 2017 mcc. All rights reserved.
//

import Foundation

var list = [Person]()

class People: NSObject, NSCoding {
    
    required init (coder aDecoder: NSCoder) {
        
        People.registerClassName()
        list = aDecoder.decodeObject(forKey: "list") as! [Person]
    }
    
    func encode(with aCoder: NSCoder) {
        
        People.registerClassName()
        aCoder.encode(list, forKey: "list")
    }
    
    enum ErrorType: Error {
        case personCannotBeLoaded
        case personCannotBeSaved
        case personCannotBeFound
        case noPersonIsSaved
        
    }
    
    static func add(thisPerson: Person) {
        
        list.append(thisPerson)
    }
    
    static func remove(thisPerson: Person) throws {
        
        guard let i = list.index(where: {$0.name == thisPerson.name}) else {
            throw ErrorType.personCannotBeFound
        }
        
        list.remove(at: i)
        
    }
    
    static func duplicateName(testString: String) -> Int {
        
        var answer = 0
        
        for eachPerson in list {
            
            if sameString(a: eachPerson.name.charsOnly(), b: testString.charsOnly()) {

                if !sameString(a: eachPerson.uid, b: Selected.person.uid) {
                    
                    answer = 2 //well then there's at least one other
                    
                    //now let's find what number to tack onto the end.
                    if let lastChar = eachPerson.name.characters.last {
                        if let lastNum = Int(String(lastChar)) {
                            if lastNum >= answer {
                                answer = lastNum + 1
                            }
                        }
                    }
                }
            }
        }
        return answer
    }
    
    static func sameString (a:String, b:String) -> Bool {
        
        var answer = false
        
        let aa = a.trimmingCharacters(in: .whitespaces)
        let bb = b.trimmingCharacters(in: .whitespaces)
        
        if aa.uppercased() == bb.uppercased() {
            answer = true
        }
        
        return answer
        
    }
    
    static func persist (ppl:[Person]) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: ppl)
        
        if let defaultGroup = Defaults.group {
            defaultGroup.set(encodedData, forKey: Key.people)
            defaultGroup.synchronize()
        }
    }
    
    
    
}




