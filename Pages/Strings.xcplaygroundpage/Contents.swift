//: [Previous](@previous)

import Foundation

//let illFormed : [CChar] = [67, 97, 102, -61, -87, 0]
//illFormed.withUnsafeBufferPointer({ ptr -> String in
//  return String(cString: ptr.baseAddress!)
//})
//
//func uniqueMorseRepresentations(_ words: [String]) -> Int {
//  let morsCodesArray : Array<String> = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
//  var resultSet = Set<String>()
//
//  for word in words {
//    let wordArr = Array(word)
//    var resultString = ""
//    for char in wordArr {
//      let index = Int(char.unicodeScalars.first!.value - 97)
//      resultString += morsCodesArray[index]
//    }
//    resultSet.insert(resultString)
//  }
//  return resultSet.count
//}
//
//func moveWeight(move: Character) -> Int {
//  switch move {
//  case "U", "L" :
//    return -1
//  case "D", "R" :
//    return 1
//  default:
//    return 0
//  }
//}
//
//func judgeCircle1(_ moves: String) -> Bool {
//  return Array(moves).map{ moveWeight(move: $0) }.reduce(0, {$0 + $1}) == 0
//}
//
//func judgeCircle2(_ moves: String) -> Bool {
//  var arr = Array(moves)
//  var dict = [Character: Int]()
//  for a in arr {
//    dict[a] = (dict[a] ?? 0)+1
//  }
//  if dict["R"] == dict["L"] && dict["U"] == dict["D"] { return true }
//  return false
//}
//
//func judgeCircle3(_ moves: String) -> Bool {
//  if moves.count % 2 != 0 {
//    return false
//  }
//  var arr = Array(moves)
//  var x = 0
//  var y = 0
//  for move in moves.unicodeScalars {
//    switch move {
//    case "U": x -= 1
//    case "D": x += 1
//    case "L": y -= 1
//    case "D": y += 1
//    default: break
//    }
//  }
//  return x == 0 && y == 0
//}

//func numSpecialEquivGroups(_ A: [String]) -> Int {
//  var setA = Set<String>()
//  guard A[0].count > 2 else {
//    A.forEach{setA.insert($0)}
//    return setA.count
//  }
//  return setA.count
//}

//struct Pairs: Hashable {
//  let index1: Int
//  let index2: Int
//}
//
//func swaps(str: String) -> Set<String> {
//  var resultArr = Set<String>()
//  var pairs = Set<Pairs>()
//  let oddArr = Array(stride(from: 1, to: str.count, by: 2))
//  let evenArr = Array(stride(from: 0, to: str.count, by: 2))
//
//  for i in 0..<oddArr.count {
//    for j in i+1..<oddArr.count {
//      pairs.insert(Pairs(index1: oddArr[i], index2: oddArr[j]))
//    }
//  }
//
//  for i in 0..<evenArr.count {
//    for j in i+1..<evenArr.count {
//      pairs.insert(Pairs(index1: evenArr[i], index2: evenArr[j]))
//    }
//  }
//
//  for pair in pairs {
//    let swappedString = swap(index1: pair.index1, index2: pair.index2, arr: Array(str))
//    resultArr.insert(swappedString)
//  }
//
//  return resultArr
//}
//
//func swap(index1: Int, index2: Int, arr: [Character]) -> String {
//  var copy = arr
//  let temp = arr[index1]
//  copy[index1] = copy[index2]
//  copy[index2] = temp
//  return String(copy)
//}
//
//swaps(str: "abcd")

//var strArr = Set<String>()
//var dict = [String: Int]()
//
//let inputString = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
//var transformedStrings = [[String]]()
//// split strings by " " empty space
//for s in inputString {
//  transformedStrings.append(s.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
//}

//var localDict = [String: Int]()
//func subdomainVisits(_ cpdomains: [String]) -> [String] {
//  for str in cpdomains {
//    let domain = str.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false).last!
//    let count = str.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false).first!
//    domainCounterForEachString(count: Int(count)!, domain: String(domain))
//  }
//  let result = localDict.compactMap{(key: String, value: Int) -> String in
//    return "\(key) \(value)"
//  }
//  return result
//}

//func domainCounterForEachString(count: Int, domain: String) {
//  let splits = domain.filter({$0 == "."}).count
//  for i in (0...splits).reversed() {
//    let string = domain.split(separator: ".", maxSplits: i, omittingEmptySubsequences: true).last!
//    localDict[String(string)] = (localDict[String(string)] ?? 0) + count
//  }
//}

//func detectCapitalUse(_ word: String) -> Bool {
//  var isLastLtrCapital = false
//  for (i,s) in word.unicodeScalars.enumerated().reversed() {
//    if i == word.count-1 && Character(s).isCapital {
//      isLastLtrCapital = true
//    } else {
//      if isLastLtrCapital {
//        if !Character(s).isCapital {
//          return false
//        }
//      } else {
//        if i > 0 && Character(s).isCapital {
//          return false
//        }
//      }
//    }
//  }
//  return true
//}

//extension Character {
//  var isCapital: Bool {
//    return self >= "A" && self <= "Z"
//  }
//}
//
//detectCapitalUse("FDf")

var mins = Set<String>()
var hours = Set<String>()

func nextClosestTime(_ time: String) -> String {
  guard time.count > 0 else { return "" }
  var ab =  Array(time)
  ab.remove(at: 2)
  let currentHour = String(ab[0]) + String(ab[1])
  let currentMin = String(ab[2]) + String(ab[3])
  let a = ab
  for i in 0..<a.count {
    for j in i+1..<a.count {
      createSets(String(a[i])+String(a[j]))
    }
    createSets(String(a[i])+String(a[i]))
  }
  
  for i in (0..<a.count).reversed() {
    for j in (0..<i).reversed() {
      createSets(String(a[i])+String(a[j]))
    }
  }
  
  if let lowestMin = lowestClosestMin(currentMin: Int(currentMin)!, array: mins) {
    return String(currentHour) + ":" + String(lowestMin)
  } else {
    if let lowestHour = lowestClosestMin(currentMin: Int(currentHour)!, array: hours) {
      return String(lowestHour) + ":" + String(hours.min()!)
    } else {
      return String(hours.min()!) + ":" + String(hours.min()!)
    }
  }
}

func createSets(_ i: String) {
  let val = Int(i)!
  if val < 24 { hours.insert(i) }
  if val < 60 { mins.insert(i) }
}

func lowestClosestMin(currentMin:Int, array: Set<String>) -> String? {
  var lowestMin = ""
  
  for min in array {
    if Int(min)! > currentMin && (lowestMin == "" || Int(min)! < Int(lowestMin)!) {
      lowestMin = min
    }
  }
  
  if !lowestMin.isEmpty { return lowestMin }
  return nil
}

//nextClosestTime("01:32")
nextClosestTime("01:37")

let v = "11A"
let endIndex = v.index(of:"A")
v[endIndex!]

extension Character {
  var isLetter: Bool {
    return self >= "a" && self <= "z"
  }
  
  var isDigit: Bool {
    guard Int(String(self)) != nil else { return false }
    return true
  }
}

func reorderLogFiles(_ logs: [String]) -> [String] {
  let letterArray = logs.filter {
    guard let firstSpace = $0.index(of: " ") else { return false }
    let startIndex = $0.index(firstSpace, offsetBy: 1)
    guard let substring = $0[startIndex..<$0.endIndex].first, substring.isLetter else { return false }
    return true
  }
  
  var sortedArray = letterArray.sorted{ ( string1, string2 ) in
    guard let firstSpace1 = string1.index(of: " ") else { return false }
    let startIndex1 = string1.index(firstSpace1, offsetBy: 1)
    let substring1 = string1[startIndex1..<string1.endIndex]
    
    guard let firstSpace2 = string2.index(of: " ") else { return false }
    let startIndex = string2.index(firstSpace2, offsetBy: 1)
    let substring2 = string2[startIndex..<string2.endIndex]
    return substring1 < substring2
  }
  
  for log in logs {
    guard let firstSpace = log.index(of: " ") else { return [] }
    let startIndex = log.index(firstSpace, offsetBy: 1)
    if let substring = log[startIndex..<log.endIndex].first, !substring.isLetter, substring.isDigit {
        sortedArray.append(log)
    }
  }
  
  return sortedArray
}

reorderLogFiles(["a 6", "a 7", "v d", "a c"])

func uniqueStrings(str: String) -> Bool {
  var boolArr = Array(repeating: false, count: 128)
  guard str.count <= 128 else { return false }
  
  for char in str.unicodeScalars {
    let index = Int(char.value)
    print("index\(index)")
    if boolArr[index] { return false }
    boolArr[index] = true
  }
  return true
}

uniqueStrings(str: "abcaA")

  var dictionary = [Int: String]()
  var tinyUrl = "http://tinyurl.com/"
  
  func CodecDriver(_ url: String) -> String {
    let encodedUrl = encode(url)
    return decode(encodedUrl) ?? ""
  }
  
  func encode(_ url: String) -> String {
    let hash = abs(url.hashValue)
    dictionary[hash] = url
    return tinyUrl+String(hash)
  }
  
  func decode(_ url: String) -> String? {
    guard let startIndex = url.lastIndex(of: "/") else { return nil }
    let strt = url.index(startIndex, offsetBy:1)
    if let hash = Int(String(url[strt..<url.endIndex])), let val = dictionary[hash] {
      return val
    } else {
      return nil
    }
  }

var minSet = Set<Int>()
func minDeletionSize(_ A: [String]) -> Int {
  if A.count < 1 { return 0 }
  
  var copy = Array<String>()
  for word in A {
    copy.append(word.trimmingCharacters(in: CharacterSet.whitespaces))
  }
  for i in 0..<copy.count-1 {
    for k in 0..<copy[i].count {
      let arrayI = Array(copy[i])
      let arrayJ = Array(copy[i+1])
      if arrayI[k] > arrayJ[k] {
        minSet.insert(k)
      }
    }
  }
  return minSet.count
}

let a = "-1i"
let end = a.index(a.startIndex, offsetBy: a.count-1)
a[a.startIndex..<end]
let b = "b"
let c = b.unicodeScalars.first
Int.random(in: 0..<10)

round(14/3)

extension String {
  func trim() -> String {
    return self.trimmingCharacters(in: .whitespaces)
  }
  func reverseString() -> String {
    var returnString = String()
    for char in self {
      returnString = String(char) + returnString
    }
    return returnString
  }
}

func reverseWords(_ s: String) -> String {
  guard !s.isEmpty else { return s }
  guard s != " " else { return s }
  for char in s {
    if char == " " {
      
    }
  }
  return s
}
