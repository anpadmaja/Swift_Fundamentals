//: [Previous](@previous)

import Foundation

class TrieNode {
  var children: [Character: TrieNode]
  var endOfWord: Bool
  var data: Int
  
  required init() {
    children = [Character: TrieNode]()
    endOfWord = false
    data = 0
  }
  
  convenience init(withData: Int) {
    self.init()
    self.data = withData
  }
}

class Trie {
  var root: TrieNode
  
  init() {
    root = TrieNode()
  }
  
  func insert(_ key: String, _ val: Int) {
    var current = root
    for char in key {
      let newNode = current.children[char] ?? TrieNode()
      current.children[char] = newNode
      current = newNode
    }
    current.data = val
    current.endOfWord = true
  }
  
  func contains(word: String) -> Bool {
    var current = root
    for char in word {
      if let val = current.children[char] {
        current = val
      } else {
        return false
      }
    }
    return current.endOfWord
  }
  
  func sum(_ prefix: String) -> Int {
    var current = root
    for char in prefix {
      if let val = current.children[char] {
        current = val
      } else {
        return 0
      }
    }
    return search_Recursive(currentPrefix: prefix, current: current)
  }
  
  func search_Recursive(currentPrefix: String, current: TrieNode) -> Int {
    var sum = 0
    if current.children.count == 0 && current.endOfWord {
      return current.data
    }
    if current.endOfWord {
      sum += current.data
    }
    
    for (key, value) in current.children {
      let currentTotal = search_Recursive(currentPrefix: currentPrefix+String(key), current: value)
      sum += currentTotal
    }
    return sum
  }
}

let a = Trie()
a.insert("app", 5)
a.insert("apt", 1)
a.insert("apple", 19)
a.contains(word: "app")
a.contains(word: "apple")
a.sum("a")
