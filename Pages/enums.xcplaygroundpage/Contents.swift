//: [Previous](@previous)

import Foundation

extension Character {
  var isDigit: Bool {
    return Int(String(self)) != nil
  }
  
  var isLetter: Bool {
    return self >= "a" && self <= "z"
  }
}

enum HTTPResponse {
  case ok
  case error(Int)
}

let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]

let sortedResponses = responses.sorted{ (ele1, ele2) in
  switch (ele1, ele2) {
  case (.ok, .ok):
    return false
  case let (.error(a), .error(b)):
    return a < b
  case (.error, .ok):
    return true
  case (.ok, .error):
    return false
  }
}

enum Type {
  case odd
  case even
}

var array = [4,2,5,7]
func sortArrayByParityII(_ A: [Int]) -> [Int] {
    array = A
    for i in 0..<array.count {
      if i%2 == 0 && array[i]%2 != 0 {
        guard let nextIndex = getNextIndex(type: .even, startingIndex: i+1) else {
          break
        }
        array.swapAt(i, nextIndex)
        
      } else if i%2 == 1 && array[i]%2 != 1 {
        guard let nextIndex = getNextIndex(type: .odd, startingIndex: i+1) else {
          break
        }
        array.swapAt(i, nextIndex)
      }
    }
    return array
}
  
  func getNextIndex(type: Type, startingIndex: Int) -> Int? {
    var x : Int = -1
    switch type {
    case .odd:
      x = 1
    case .even:
      x = 0
    }
    guard startingIndex < array.count else { return nil }
    var j = startingIndex
    while(array[j]%2 != x) {
      j += 1
    }
    return j
  }

sortArrayByParityII([4,2,5,7])
