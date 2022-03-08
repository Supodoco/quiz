import UIKit
import SwiftUI

//var str = "Hello, playground"
//
//class Shape {
//    var numberOfSides = 0
//    func simpleDescription() -> String {
//        return "A shape with \(numberOfSides) sides."
//    }
//}
//var shape = Shape()
//shape.numberOfSides = 7
//var shapeDescription = shape.simpleDescription
//var sideLength: Double = 3.4
//var perimeter: Double {
//        get {
//            return 3.0 * sideLength
//        }
//        set {
//            sideLength = newValue / 3.0
//        }
//
//}
//print(perimeter)
//perimeter = 12.3
//print(sideLength)
//var qwwq = 0.123e2
//typealias AudioSample = UInt8
//var musicMax = AudioSample.init(12)
//musicMax = 120
//
//
//var possibleNumber: String? = "123"
//var convertedNumber = Int(possibleNumber ?? "nil")
//if let x: Int = convertedNumber {
//    print(x)
//} else {
//    print("possibleNumber isn't Int Type or nil")
//}
//enum Erooor {
//    case outOfranger
//}
//func index123() throws {
//    while musicMax <= 250 {
//        musicMax += 12
//    }
//    print(musicMax)
//}
//do {
//    try index123()
//    print(musicMax)
//} catch {
//    print("Out of range! MusicMax = \(musicMax)")
//}
//var cxc = (3, "aphjgfkjh") < (3, "bird")
//var counter = 0
//print("\n")
//
//
//
//var allowedEntry = false
//func allow() {
//    if !allowedEntry {
//        print("ACCESS DENIED")
//    } else {
//        print("ACCESS SUCCSES")
//    }
//}
//allowedEntry = true
//allow()
//let softWrappedQuotation = """
//The White Rabbit put on his spectacles.  "Where shall I begin,
//please your Majesty?" he asked. 67666679967574ewtsdhgfjvkhbk
//l
//"Begin at the beginning," the King said gravely, "and go on \
//till you come to the end; then stop."
//"""
//print(softWrappedQuotation)
//for char in "0||1" {
//print("\(char)\(char)")
//    if char == "1" {
//        print(0)
//    }
//}
//print(#""6 times 7 is \#(6 * 7).""#)
//let greeting = "Guten Tag!"
//greeting[greeting.startIndex]
//// G
//greeting[greeting.index(before: greeting.endIndex)]

var ccc = 0
var select1 = 12 {
    willSet {
        print(select1)
        ccc += 1
        print(ccc)
    }
    didSet {
        print(select1)
        ccc += 1
        print(ccc)
    }
}
select1 = 11

var myPropertyValue: Int = 0
    var myProperty: Int {
        get {
            return myPropertyValue }
        set {
            print("The value of myProperty changed from \(myPropertyValue) to \(newValue)")
            myPropertyValue = newValue
        }
    }
print(myProperty)
myPropertyValue = 1
myProperty = 12
print(myProperty)
