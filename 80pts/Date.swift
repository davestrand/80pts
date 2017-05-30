//
//  Date.swift
//  80pts
//
//  Created by Levy,David A. on 12/22/16.
//  Copyright © 2016 mcc. All rights reserved.
//


var dateArray = DateArray(today: [0,0,0], floating: [0,0,0], printable: [0,0,0], printableString: "")

protocol Data {
    var today: [Int] { get }
    var floating: [Int] { get }
    var printable: [Int] { get }
    var printableString: String { get }
}


struct DateArray: Data {
    var today: [Int]
    var floating: [Int]
    var printable: [Int]
    var printableString: String

}

