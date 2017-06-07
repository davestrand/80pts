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
    

    
}

extension People {
    
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
    
    static func persist (ppl:[Person]) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: ppl)
        
        if let defaultGroup = Defaults.group {
            
            defaultGroup.set(encodedData, forKey: Key.people)
            
            defaultGroup.synchronize()
            
        } else {
            print("PEOPLE PROBLEM")
        }
        
        
        
    }

    }
    
    




