//: [Previous](@previous)

import Foundation

//public struct HashTable<Key: Hashable, Value> {
//  private typealias Element = (key: Key, value: Value)
//  private typealias Bucket = [Element]
//  private var buckets : [Bucket]
//
//  private (set) public var count = 0
//
//  var isEmpty: Bool {
//    return count == 0
//  }
//
//  init(capacity: Int) {
//    buckets = Array(repeating: [], count: capacity)
//  }
//
//  subscript(key: Key) -> Value? {
//    get {
//      return value(forKey: key)
//    }
//    set {
//      if let value = newValue {
//        updateValue(forKey: key, value: value)
//      } else {
//        remove(key: key)
//      }
//    }
//  }
//
//  func value(forKey key: Key) -> Value? {
//    let index = self.index(forKey: key)
//    let bucket = buckets[index]
//    for element in bucket {
//      if element.key == key { return element.value }
//    }
//    return nil
//  }
//
//  @discardableResult mutating func updateValue(forKey key: Key, value: Value) -> Value? {
//    let index = self.index(forKey: key)
//    for (i, element) in buckets[index].enumerated() {
//      if element.key == key {
//        let oldVal = element.value
//        buckets[index][i].value = value
//        return oldVal
//      }
//    }
//
//    buckets[index].append((key: key, value: value))
//    count += 1
//    return nil
//  }
//
//  @discardableResult mutating func remove(key: Key) -> Value? {
//    let index = self.index(forKey: key)
//    for (index, element) in buckets[index].enumerated() {
//      if element.key == key {
//        buckets[index].remove(at: index)
//        count -= 1
//        return element.value
//      }
//    }
//    return nil
//  }
//
//  mutating func removeAll() {
//    buckets = Array(repeating: [], count: buckets.count)
//  }
//
//  private func index(forKey key: Key) -> Int {
//    return abs(key.hashValue) % buckets.count
//  }
//}
//
//
//// Playing with the hash table
//var hashTable = HashTable<String, String>(capacity: 5)
//
//hashTable["firstName"] = "Steve"
//hashTable["lastName"] = "Jobs"
//hashTable["hobbies"] = "Programming Swift"
//
//print(hashTable)
//
//let x = hashTable["firstName"]
//hashTable["firstName"] = "Tim"
//
//let y = hashTable["firstName"]
//hashTable["firstName"] = nil
//
//let z = hashTable["firstName"]
//
//print(hashTable)

class Stack {
  var list: [Int]
  init() {
    list = [Int]()
  }
  func push(val: Int) {
    list.append(val)
  }
  func pop() -> Int? {
    guard list.count > 0 else { return nil }
    return list.removeLast()
  }
}

class Queue {
  var list: [Int]
  init() {
    list = [Int]()
  }
  func enqueue(val: Int) {
    list.append(val)
  }
  func dequeue() -> Int? {
    guard list.count > 0 else { return nil }
    return list.removeFirst()
  }
  func contains(val: Int) -> Bool {
    return list.contains(val)
  }
  func printAll() {
    list.forEach({print($0)})
  }
}

class Solution {
  var dictionary = [Int: [Int]]()
  var returnArray = [[Int]]()
  
  func allPathsSourceTarget(_ graph: [[Int]]) {
    for (index,value) in graph.enumerated() {
      dictionary[index] = value
    }
    var path = [0]
    depthFirstSearch(node: 0, path: &path, response: &returnArray, destination: graph.count-1)
  }
  
  func depthFirstSearch(node: Int, path: inout [Int], response: inout [[Int]], destination: Int) {
    if node == destination {
      response.append(path)
      return
    }
     if let neighbors = dictionary[node] {
        for n in neighbors {
          path.append(n)
          depthFirstSearch(node: n, path: &path, response: &response, destination: destination)
          path.removeLast()
        }
    }
  }
}

//let g = [[1,2], [3], [3], []]
//let s = Solution()
//s.allPathsSourceTarget(g)
//s.returnArray

  func matrixScore(_ A: [[Int]]) -> Int {
    var matrix = A
    for i in 0..<matrix.count {
      let currentVal = getDecimalValue(array: matrix[i])
      let flippedArray = flipArray(array: matrix[i])
      let currentFlippedVal = getDecimalValue(array: flippedArray)
      if currentFlippedVal > currentVal {
        matrix[i] = flippedArray
      }
    }
    
    for i in 0..<matrix[0].count {
      var column = [Int]()
      for j in 0..<matrix.count {
        print("going inside column decimalValue function")
        column.append(matrix[j][i])
      }
      print("going inside column decimalValue function 1")
      let currentVal = getDecimalValue(array: column)
      let flippedArray = flipArray(array: column)
      let currentFlippedVal = getDecimalValue(array: flippedArray)
      if currentFlippedVal > currentVal {
        for j in 0..<flippedArray.count {
          print("i: \(i), j: \(j)")
          matrix[j][i] = flippedArray[j]
        }
      }
    }
    return sumOfMatrix(matrix: matrix)
  }
  
  func flipArray(array: [Int]) -> [Int] { // 1111
    print("inside flip array")
    var returnArray = [Int]()
    for a in array {
      if a == 0 {
        returnArray.append(1)
      } else  if a == 1 {
        returnArray.append(0)
      } else {
        return []
      }
    }
    return returnArray
  }
  
  func getDecimalValue(array:[Int]) -> Int {
    print("inside decimal value")
    var returnString = ""
    for a in array {
      returnString.append(String(a))
    }
    return Int(returnString, radix:2) ?? 0
  }

func sumOfMatrix(matrix: [[Int]]) -> Int {
  var sum = 0
  for i in 0..<matrix.count {
    sum += getDecimalValue(array: matrix[i])
  }
  return sum
}

let a = [[0,0,1,1]]
matrixScore(a)
