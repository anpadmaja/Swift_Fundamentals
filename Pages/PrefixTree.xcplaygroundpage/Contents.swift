//: [Previous](@previous)

import Foundation

class TrieNode {
  var children: [Character: TrieNode]
  var endOfWord: Bool

  init() {
    children = [Character: TrieNode]()
    endOfWord = false
  }
}

class Trie {
  var root: TrieNode
  var wordsArr: [String]
  
  init() {
    root = TrieNode()
    self.wordsArr = [String]()
  }
  
  var isEmtpy: Bool {
    return root.children.count == 0 && !root.endOfWord
  }
  
  func contains(word: String) -> Bool {
    var current = root
    for char in word {
      guard let node = current.children[char] else { return false }
      current = node
    }
    return current.endOfWord
  }
  
  func add(word: String) {
    var current = root
    for char in word {
      let node = current.children[char] ?? TrieNode()
      current.children[char] = node
      current = node
    }
    current.endOfWord = true
  }
  
  func add(words: [String]) {
    for word in words {
      add(word: word)
    }
  }
  
//  func search_Another(word:String) -> Bool {
//    var current = root
//    return search_Recursive(word: word, index: 0, current: current)
//  }
//
//  func search_Recursive(word: String, index: Int, current: TrieNode) -> Bool {
//    if index == word.count && current.endOfWord {
//        return true
//    } else if index == word.count && !current.endOfWord { return false }
//
//    let endIndex = word.index(word.startIndex, offsetBy: index)
//    let char = word[endIndex]
//    guard let val = current.children[char] else { return false }
//    return search_Recursive(word: word, index: index+1, current: val)
//  }

  func search(prefix: String) -> [String] {
    var current = root
    for char in prefix {
      if let val = current.children[char] {
        current = val
      }
    }
    return search_Int(currentNode: current, currentPrefix: prefix)
  }
  
  func search_Int(currentNode: TrieNode, currentPrefix: String) -> [String] {
    if currentNode.children.count == 0 && currentNode.endOfWord {
      wordsArr.append(currentPrefix)
      return wordsArr
    }
    if currentNode.endOfWord {
      wordsArr.append(currentPrefix)
    }
    for (key, val) in currentNode.children {
      wordsArr = search_Int(currentNode: val, currentPrefix: currentPrefix+String(key))
    }
    return wordsArr
  }
  
  func delete_Another(word: String) -> Bool {
    let current = root
    return delete_Recursive(word: word, index: 0, current: current)
  }
  
  private func delete_Recursive(word: String, index: Int, current: TrieNode) -> Bool {
    var shouldDeleteNode = false
    if index == word.count && current.children.count > 0 && current.endOfWord {
      current.endOfWord = false
      return false
    } else if index == word.count && current.children.count == 0 && current.endOfWord {
      return true
    }
    
    let endIndex = word.index(word.startIndex, offsetBy: index)
    let char = word[endIndex]
    if let val = current.children[char] {
      shouldDeleteNode = delete_Recursive(word: word, index: index+1, current: val)
      if shouldDeleteNode {
        current.children.removeValue(forKey: char)
        if current.children.count > 0 {
          return false
        } else if current.children.count == 0 && !current.endOfWord {
          return true
        } else {
          return false
        }
      }
    }
    return false
  }
  
}

let trie1 = Trie()
trie1.add(word: "cat")
trie1.add(word: "cap")
trie1.add(word: "cg")
trie1.add(word: "cats")
trie1.contains(word: "cat")
trie1.contains(word: "cap")
trie1.delete_Another(word: "cg")
trie1.search(prefix: "c")


