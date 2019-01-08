//: [Previous](@previous)

class Test {
  var name: String
  var count: Int
  init() {
    self.name = "z"
    self.count = 1
  }
}

class TrieNode {
  var children: [Character: TrieNode]
  var endNode: Bool

  init() {
    self.children = [Character: TrieNode]()
    self.endNode = false
  }
}

class Trie {
  let root: TrieNode
  var wordsArr: [String]

  init() {
    self.root = TrieNode()
    self.wordsArr = [String]()
  }
  
  func insert(_ words: [String]) {
    var current = root
    for word in words {
      let arr = Array(word)
      for i in 0..<arr.count {
        let node = current.children[arr[i]] ?? TrieNode()
        current.children[arr[i]] = node
        current = node
      }
      current.endNode = true
    }
  }

  func insert(_ word: String) {
    var current = root
    let arr = Array(word)
    for i in 0..<arr.count {
      let node = current.children[arr[i]] ?? TrieNode()
      current.children[arr[i]] = node
      current = node
    }
    current.endNode = true
  }

  func insertRecursive(_ word: String) {
    let array = Array(word)
    insertRecursive_helper(array, root, 0)
  }

  func insertRecursive_helper(_ word: [Character], _ current: TrieNode,_ index: Int ) {
    if index == word.count {
      current.endNode = true
      return
    }
    let node = current.children[word[index]] ?? TrieNode()
    current.children[word[index]] = node
    insertRecursive_helper(word, node, index+1)
  }

  func search(_ word: String) -> Bool {
    let wordArr = Array(word)
    var current = root
    for i in 0..<wordArr.count {
      guard let node = current.children[wordArr[i]] else { return false }
      current = node
    }
    return current.endNode
  }

  func search(with prefix: String) -> Bool {
    let prefix = Array(prefix)
    var current = root
    for i in 0..<prefix.count {
      guard let node = current.children[prefix[i]] else { return false }
      current = node
    }
    return true
  }
  
  func returnWordsWith(prefix: String) -> [String] {
    var current = root
    var currPrefix = Array(prefix)
    for i in 0..<currPrefix.count {
      guard let node = current.children[currPrefix[i]] else { return [] }
      current = node
    }
    return returnWordsWith_Internal(currPrefix: prefix, stopNode: current, origPrefix: prefix)
  }

  func returnWordsWith_Internal(currPrefix: String, stopNode: TrieNode, origPrefix: String) -> [String] {
    if stopNode.endNode == true && stopNode.children.count == 0 {
      wordsArr.append(currPrefix)
      return wordsArr
    }
    for key in stopNode.children.keys {
      if let st = stopNode.children[key] {
        wordsArr = returnWordsWith_Internal(currPrefix: origPrefix + String(key), stopNode: st, origPrefix: origPrefix+String(key))
      }
    }
    return wordsArr
  }
  
  func longestWord() -> [String] {
    let current = root
    return longestWord_Int(currPrefix: "", stopNode: current, isRoot: true)
  }
  
  func longestWord_Int(currPrefix: String, stopNode: TrieNode, isRoot: Bool) -> [String] {
    if stopNode.endNode == true && stopNode.children.count == 0 {
      wordsArr.append(currPrefix)
      return wordsArr
    }
    
    if stopNode.endNode == true {
      wordsArr.append(currPrefix)
    }
    
    if stopNode.endNode == false && !isRoot {
      return wordsArr
    }
    
    for key in stopNode.children.keys {
      if let st = stopNode.children[key] {
        wordsArr = longestWord_Int(currPrefix: currPrefix + String(key), stopNode: st, isRoot: false)
      }
    }
    return wordsArr
  }
}

let try1 = Trie()
//try1.insert("graph")
//try1.insert("grape")
//try1.insert("grow")
//try1.insert("group")
//try1.insert("green")
//try1.returnWordsWith(prefix: "gre")
//try1.insert("w")
//try1.insert("wo")
//try1.insert("wor")
//try1.insert("worl")
//try1.insert("world")
//try1.insert("banana")
//try1.insert("g")
//try1.insert("gr")
//try1.insert("gra")
//try1.insert("grap")
//try1.insert("graph")
//try1.longestWord()
let words = ["w","wo","wor","worl","world", "ban"]
for word in words {
  try1.insert(word)
}
try1.longestWord()

