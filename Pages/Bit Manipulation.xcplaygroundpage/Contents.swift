//: [Previous](@previous)

import Foundation

struct BitVector {
  private let wordSize: Int = 32
  var vector: [Int]
  private let totalBitLength: Int
  
  init(size: Int) {
    let count = abs(size/wordSize)+1
    vector = Array(repeating: 0, count: count)
    totalBitLength = size
  }
  
  mutating func setBit(int: Int) -> Bool {
    guard int <= totalBitLength else { return false }
    let wordIndex = abs(int/wordSize)
    let word = vector[wordIndex]
    let mask = 1 << (int%wordSize)
    
    if word & mask != 0 {
      return false
    } else {
      vector[wordIndex] = word | mask
    }
    return true
  }
  
  func getBit(int: Int) -> Int {
    guard int <= totalBitLength else { return -1 }
    let wordIndex = int/wordSize
    let word = vector[wordIndex]
    let mask = 1 << (int%wordSize)
    if word & mask > 0 {
      return 1
    }
    return 0
  }
}

//var testVector = BitVector(size: 63)
//testVector.vector.count
//testVector.setBit(int: 63)
//1<<63
//String(1<<64, radix:2)
//pow(2.0, 63.0)

var a: UInt32 = 15
var mask: UInt32 = 1
var count1Bits = 0

for _ in 0..<32 {
  if a & mask != 0 { count1Bits += 1}
  mask <<= 1
}

count1Bits

func flipLSB(n : Int) -> Int {
  var x = n
  var count = 0
  
  while x != 0 {
    x = x & (x-1)
    count += 1
  }
  return count
}
flipLSB(n: 511)
5.nonzeroBitCount
7.nonzeroBitCount
