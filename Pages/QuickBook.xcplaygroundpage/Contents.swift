//: [Previous](@previous)

import Foundation

protocol Ordered {
  func precedes(other: Self) -> Bool
}

struct Number: Ordered {
  var value: Int = 0
  func precedes(other: Number) -> Bool {
    return value < other.value
  }
}

var arr = [Number(value: 1),Number(value: 2),Number(value: 3),Number(value: 4)]

func binarySearch<T: Ordered>(arr: [T], key: T) -> Int {
  var low = 0
  var high = arr.count
  while high > low {
    let mid = low + (high - low)/2
    if arr[mid].precedes(other: key) {
     low = mid+1
    } else {
      high = mid
    }
  }
  return low
}
binarySearch(arr: arr, key: Number(value: 10))


class Node {
  var val: Int
  var childrens: [Node]?
  var depthOfNode: Int = 0
  
  init() {
    childrens = [Node]()
    val = 0
  }
  
  func maxDepth() -> Int {
    guard let children = childrens else { return  1 }
    for child in children {
      let depth = child.maxDepth()
      depthOfNode = depth > depthOfNode ? depth : depthOfNode
    }
    return 1 + depthOfNode
  }
}



