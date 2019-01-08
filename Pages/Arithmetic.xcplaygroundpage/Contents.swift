//: [Previous](@previous)

import Foundation

func sum() -> Int {
  var sum3 = 0
  var sum5 = 0
  var sum15 = 0
  for i in 0..<1000 {
    if i % 3 == 0 {
      sum3 += i
    }
    if i % 5 == 0 {
      sum5 += i
    }
    if i % 15 == 0 {
      sum15 += i
    }
  }
  return sum3 + sum5 - sum15
}

sum()

func calculateSum(array: [Int], upto: Int) -> Int {
  var sumNew = 0
  for a in array {
    let till = abs(upto/a)
    print(till)
    sumNew += a * sumOfArithmeticSeries(upto: till)
  }
  let multiple = array.reduce(1, {$0 * $1})
  let last = multiple * sumOfArithmeticSeries(upto: abs(upto/multiple))
  return sumNew-last
}

func sumOfArithmeticSeries(upto n: Int) -> Int {
  return n * (1 + n)/2
}

sumOfArithmeticSeries(upto: 10)
calculateSum(array: [3,5], upto: 999)

let x = 40
x.quotientAndRemainder(dividingBy: 5)

for i in 0..<10 {
  print("\(Int.random(in: 1...10))")
}
