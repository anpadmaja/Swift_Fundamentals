//: [Previous](@previous)

import Foundation

func quickSort(a: [Int]) -> [Int] {
  var array = a
  return quickSort_Helper(a: &array, firstIdx: 0, lastIdx: array.count-1)
}

func quickSort_Helper(a: inout [Int], firstIdx: Int, lastIdx: Int) -> [Int] {
  if lastIdx-firstIdx < 5 {
    a.sort()
  } else {
    let pivotIdx = orderMedian(a: &a, firstIdx: firstIdx, lastIdx: lastIdx)
    print("pivotIdx \(pivotIdx)")
    quickSort_Helper(a: &a, firstIdx: firstIdx, lastIdx: pivotIdx-1)
    quickSort_Helper(a: &a, firstIdx: pivotIdx+1, lastIdx: lastIdx)
  }
  return a
}

func orderMedian(a: inout [Int], firstIdx: Int, lastIdx: Int) -> Int {
  let medianIdx = (firstIdx+lastIdx)/2
  print("medianIdx index \(medianIdx)")
  if a[firstIdx] >= a[medianIdx] { a.swapAt(firstIdx, medianIdx) }
  if a[firstIdx] >= a[lastIdx] { a.swapAt(firstIdx, lastIdx) }
  if a[medianIdx] >= a[lastIdx] { a.swapAt(medianIdx, lastIdx) }
//  a.forEach({print($0)})
//  print("****")
  a.swapAt(medianIdx, lastIdx-1)
  a.forEach({print($0)})
  return partition(&a, firstIdx+1, lastIdx-2, lastIdx-1)
}

func partition(_ array: inout [Int],_ firstIdx: Int,_ lastIdx: Int, _ pivotIdx: Int) -> Int {
  print("pivot index \(pivotIdx)")
  print("firstIdx index \(firstIdx)")
  print("lastIdx index \(lastIdx)")
  let pivotVal: Int = array[pivotIdx]
  var left = firstIdx
  var done = false
  var right = lastIdx
  while !done {
    while array[left] < pivotVal {
      left += 1
    }
    while array[right] > pivotVal {
      right -= 1
    }
    if left < right {
    array.swapAt(left, right)
    left += 1
    right -= 1
    } else {
      done = true
    }
  }
  array.swapAt(left, pivotIdx)
  return left
}

var arr = [9,1,8,2,6,3,7,4,5]
let c = quickSort(a: arr)
c
