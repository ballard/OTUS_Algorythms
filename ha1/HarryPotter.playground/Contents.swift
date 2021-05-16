import UIKit

var str = "Hello, playground"

let edge = 25

for x in 0...edge {
    var str = ""
    for y in 0...edge {
        str.append(CGFloat(x) < CGFloat(edge / 2) + 2 * sin(CGFloat(y/5)) ? " # " : " . ")
    }
    print(str)
}

// 01 - "x < y ? " # " : " . ""
// 02 - "x == y ? " # " : " . ""
// 03 - "x == edge - y ?  " # " : " . ""
// 04 - "x <= edge - y + 5 ?  " # " : " . ""
// 05 - "y == x * 2 || y == (x*2) + 1 ?  " # " : " . ""
// 06 - "x < edge/3 || y < edge/3 ? " # " : " . ""
// 07 - "x > edge/3*2 && y > edge/3*2 ? " # " : " . ""
// 08 - "x == 0 || y == 0 ? " # " : " . ""
// 09 - "x > y + edge/3 || y > x + edge/3 ? " # " : " . ""
// 10 - "y <= 2 * x + 1 && x <= y - 1 ? " # " : " . ""
// 11 - "x == 1 || y == 1 || x == edge - 1 || y == edge - 1 ? " # " : " . ""
// 12 -
// 15 - "x + 3 < y + edge && x > y + edge/3 || y > x + edge/3 && y < x + edge - 3 ? " # " : " . ""
// 16 - "x <= y + edge - 14 && y <= x + edge - 16 && x < edge - y + 11 && x > edge - y - 11 ? " # " : " . ""
// 17 -
