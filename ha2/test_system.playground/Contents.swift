import UIKit

var greeting = "Hello, playground"

let inputExtension = "in"
let outputExtension = "out"

struct TestSystem { }

protocol Task {
    func run(_ content: String) -> Int
}

struct Tester {
    let task: Task
    let path: String
    
    func runTests() {
        
        guard let intputUrls = Bundle.main.urls(forResourcesWithExtension: inputExtension, subdirectory: path) else {
            return
        }
        
        guard let outputUrls = Bundle.main.urls(forResourcesWithExtension: outputExtension, subdirectory: path) else {
            return
        }
        
        let sortedInput = intputUrls.sorted { $0.absoluteString < $1.absoluteString}
        let sortedOutput = outputUrls.sorted { $0.absoluteString < $1.absoluteString}
        
        for (index, url) in zip(sortedInput, sortedOutput).enumerated() {
            guard let input = try? String(contentsOf: url.0).trimmingCharacters(in: .whitespacesAndNewlines),
                  let output = try? String(contentsOf: url.1).trimmingCharacters(in: .whitespacesAndNewlines) else {
                continue
            }
            print("input url: \(url.0.absoluteString), content: \(input)")
            print("output url \(url.1.absoluteString), content: \(output)")
            let result = runTest(input: input, output: output)
            print("Test #\(index) - result \(result)")
            print()
        }
    }
    
    private func runTest(input: String, output: String) -> Bool {
        let result = task.run(input)
        let expected = Int(output)
        return result == expected
    }
}

// MARK:- test string length
struct StringLengthTask: Task {
    func run(_ content: String) -> Int {
        content.count
    }
}

extension TestSystem {
    func runStringLen() {
        Tester(task: StringLengthTask(), path: "0.String").runTests()
    }
}

//TestSystem().runStringLen()

// MARK:- test lucky tickets
final class LuckyTicketRecursiveTask: Task {
    
    var n = 0
    var q = 0
    
    func run(_ content: String) -> Int {
        guard let num = Int(content) else {
            return 0
        }
        n = num
        q = 0
        print("num: \(num)")
        nextDigit(digit: 0, sum1: 0, sum2: 0)
        print("q: \(q)")
        return q
    }
    
    private func nextDigit(digit: Int, sum1: Int, sum2: Int) {
        if digit == n {
            if sum1 == sum2 {
                q += 1
            }
            return
        }
        for i in 0...9 {
            for j in 0...9 {
                nextDigit(digit: digit + 1, sum1: sum1 + i, sum2: sum2 + j)
            }
        }
    }
}

extension TestSystem {
    func runLuckyTicket() {
        Tester(task: LuckyTicketRecursiveTask(), path: "1.Tickets").runTests()
    }
}

//TestSystem().runLuckyTicket()


final class LuckyTicketDynamic: Task {
    
    var source = [Int]()
    
    func run(_ content: String) -> Int {
        
        guard let num = Int(content) else {
            return 0
        }
        
        if num == 1 {
            return 10
        }
        
        source = (0...9).map { _ in return 1 }
        var result = 0
        
        for i in 2...num {
            result = calculate(i)
        }
        
        print("result: \(result)")
        return result
    }
    
    private func calculate(_ num: Int) -> Int {
        
        let tempArray = (0..<num*9).map { _ in return 0 }
        
        var tempArrays = [[Int]]()
        
        for i in 0...9 {
            var array = tempArray
            array.replaceSubrange((i..<i+source.count-1), with: source)
            tempArrays.append(array)
        }
        
        var sumArray = [Int]()
        
        for i in 0...num*9 {
            var count = 0
            for j in 0..<tempArrays.count {
                count += tempArrays[j][i]
            }
            sumArray.append(count)
        }
        
        let value = sumArray.reduce(0, { result, number in
            result + (number * number)
        })
        
        source = sumArray
        return value
    }
}

extension TestSystem {
    func runLuckyTicketDynamic() {
        Tester(task: LuckyTicketDynamic(), path: "1.Tickets").runTests()
    }
}

TestSystem().runLuckyTicketDynamic()
