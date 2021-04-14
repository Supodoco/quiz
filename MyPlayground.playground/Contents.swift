import UIKit

var str = "Hello, playground"
var list = [Any]()
list.append(12)
list.append("hello")
list.append(12.212121)
list.append(str)
list.append(0.0)
list.append(0)
list.append(CGFloat(32))
list.append(str)
let optionalNumber: Int? = 123456
list.append(optionalNumber as Any)
let optionalString: String? = "hero"
list.append(optionalString as Any)

print(list)

//for x in list {
//    if case let x as String {
//        print("Text: \(x)")
//    } else if x is Int {
//        print("Int: \(x)")
//    } else if x is Double {
//        print("Double: \(x)")
//    } else if x is CGFloat {
//        print("CGFloat: \(x)")
//    } else {
//        print("Other: \(x)")
//    }
//}
