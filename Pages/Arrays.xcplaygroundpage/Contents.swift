//: [Previous](@previous)

import Foundation

var array = Array<Int>()
  func sortArrayByParity(_ A: [Int]) -> [Int] {
    guard A.count > 1 else { return A }
    array = A
    var j = array.count-1
    var i = 0
    
    while(j>i) {
      if array[i].isOdd && !array[j].isOdd {
        array.swapAt(i, j)
        i += 1
        j -= 1
      } else if array[i].isOdd && array[j].isOdd {
        j -= 1
      } else if !array[i].isOdd && !array[j].isOdd {
        i += 1
      } else {
        i += 1
        j -= 1
      }
    }
    return array
  }
  
  func isOdd(number: Int) -> Bool {
    return number%2 != 0
  }


extension Int {
  var isOdd: Bool {
    return self%2 != 0
  }
}

func isValidCurrency(curr: Int) -> Bool {
  return curr == 5 || curr == 10 || curr == 20
}

let chal = [5,5,5,20,5,10]

func lemonadeChange(_ bills: [Int]) -> Bool {
  var five: Int = 0
  var ten: Int = 0
  var twenty: Int = 0
  
  for bill in bills {
    guard isValidCurrency(curr: bill) else { return false }
    
    if bill > 5 {
      let change = bill-5
      if change == 5 {
        if five > 0 {
          five -= 1
        } else {
          return false
        }
      } else if change == 15 {
        if five >= 3 {
          five -= 3
        } else if ten > 0 && five > 0 {
          ten -= 1
          five -= 1
        } else {
          print(ten)
          print(five)
          return false
        }
      } 
    }
    
    if bill == 5 {
      five += 1
    } else if bill == 10 {
      ten += 1
    } else if bill == 20 {
      twenty += 1
    } else {
      return false
    }
  }
  return true
}

let z = lemonadeChange(chal)

extension Array where Element : Comparable {
  func countUniques() -> Int {
    let sorted = self.sorted(by: <)
    let initial: (Element?, Int) = (.none, 0)
    let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
    return reduced.1
  }
}

struct Cell {
  var name: String
}

let a = Optional
