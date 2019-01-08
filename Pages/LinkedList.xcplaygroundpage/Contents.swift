//: [Previous](@previous)

class Node<T> : Equatable where T: Equatable {
  var value: T
  var next: Node?
  
  init(value: T) {
    self.value = value
  }
  
  public static func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.value == rhs.value
  }
}

//let a = Node<Int>(value:1)
//let b = Node<Int>(value:2)
//let c = Node<Int>(value:3)
//a.next = b
//b.next = c

//printRecursive(root: a)
//let rest = reverse(root: a)
//printRecursive(root: rest)

class LinkedList<T> where T: Equatable {
  var root: Node<T>?
  var size : Int
  
  init() {
    root = nil
    size = 0
  }

  init(value: T) {
    self.root = Node(value: value)
    size = 1
  }
  
  func printRecursive(root: Node<T>?) {
    guard let current = root else { return }
    print("node value is \(current.value)")
    return printRecursive(root: current.next)
  }
  
  func reverse() -> Node<T>? {
    return reverseHelper(root: root)
  }
  
  private func reverseHelper(root: Node<T>?) -> Node<T>? {
    guard let current = root else { return nil }
    guard let nextNode = current.next else { return current }
    current.next = nil
    let rest = reverseHelper(root: nextNode)
    // setting the next after the recursive call since the 1 -> 2 will become 2 -> 1 and this will keep looping
    nextNode.next = current
    return rest
  }
  
  func addToFirst(node: Node<T>) -> Node<T> {
    guard let current = root else {
      root = node
      size += 1
      return node
    }
    node.next = current
    root = node
    size += 1
    return current
  }

  func addToLast(node: Node<T>) -> Node<T> {
    guard var current = root else {
      root = node
      size += 1
      return node
    }
    while let next = current.next {
      current = next
    }
    current.next = node
    size += 1
    return current
  }

  func addTo(index: Int, nodeToAdd: Node<T>) -> Node<T> {
    guard var current = root else {
      root = nodeToAdd
      size += 1
      return nodeToAdd
    }
    guard index > -1, index <= size else { preconditionFailure("index out of bounds") }
    
    guard index != 0 else {
      return addToFirst(node: nodeToAdd)
    }
    var count = 0
    while count < index-1, let nextNode = current.next {
      current = nextNode
      count += 1
    }
    nodeToAdd.next = current.next
    current.next = nodeToAdd
    size += 1
    return current
  }

  func removeFromFirst() -> Node<T>? {
    guard let current = root else { return nil }
    guard let nextNode = current.next else {
      root = nil
      size -= 1
      return nil
    }
    root = nextNode
    size -= 1
    return root
  }
  
  func removeFromLast() -> Node<T>? {
    var count = 0
    guard var current = root else { return nil }
    guard current.next != nil else {
      root = nil
      size -= 1
      return root
    }
    while count < size-2, let nextN = current.next {
      count += 1
      current = nextN
    }
    current.next = nil
    size -= 1
    return current
  }
  
  func removeAt(index: Int) -> Node<T>? {
    guard var current = root else { return nil }
    guard index > -1, index <= size-1 else { preconditionFailure("index out of bounds")}
    guard index != 0 else { return removeFromFirst() }
    guard index != size-1 else { return removeFromLast() }
    var count = 0
    while count < index-1, let nextN = current.next {
      count += 1
      current = nextN
    }
    current.next = current.next?.next
    size -= 1
    return current
  }
  
  func hasCycle() -> Bool {
    guard let current = root else { return false }
    var slow = current.next
    var fast = current.next?.next
    while slow != fast {
      slow = slow?.next
      fast = fast?.next?.next
    }
    guard let slowN = slow, let fastN = fast else { return false }
    return slowN == fastN
  }
  
  func isPalindrome(_ head: Node<T>?) -> Bool {
    guard var current = head else { return false }
    var length = 1
    var compString = ""
    while let next = current.next {
      length += 1
      current = next
    }
    print(length)
    let listLength: Int = length%2 == 0 ? length/2+1 : (length/2)+1
    guard var curr = head, let val = curr.value as? String else { return false }
    compString = val
    for _ in 0..<listLength-1 {
      if let next = curr.next {
        curr = next
        compString += String(describing: curr.value)
      }
    }
    print(compString)
    let recursionResult = isPalindrome_Helper(root: head, length: length, compLength: compString.count)
    return compString == recursionResult
  }
  
  func isPalindrome_Helper(root: Node<T>? , length: Int, compLength: Int ) -> String {
    guard let current = root else { return "" }
    var returnString = isPalindrome_Helper(root: current.next, length: length-1, compLength:compLength)
    if length <= compLength {
      returnString += String(describing: current.value)
    }
    return returnString
  }
}

//let node1 = Node(value: "m")
//let node2 = Node(value: "a")
//let node3 = Node(value: "l")
//let node4 = Node(value: "a")
//let node5 = Node(value: "y")
//let node6 = Node(value: "a")
//let node7 = Node(value: "l")
//let node8 = Node(value: "a")
//let node9 = Node(value: "m")
//
//node1.next = node2
//node2.next = node3
//node3.next = node4
//node4.next = node5
//node5.next = node6
//node6.next = node7
//node7.next = node8
//node8.next = node9

//let ll = LinkedList<Int>()
//ll.root = node1
//ll.hasCycle()
//ll.isPalindrome(node1)


public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
}

func sortList(_ head: ListNode?) -> ListNode? {
  return split_logn(head)
}

func split_logn(_ head: ListNode?) -> ListNode? {
  guard let startNode = head else { return nil }
  let length = getLength(head)
  if length <= 2 {
    if length == 2 {
      let next = startNode.next
      startNode.next = nil
      let l1 = split_logn(startNode)
      let l2 = split_logn(next)
      return merge(l1: l1, l2: l2)
    } else {
      return startNode
    }
  }
  let mid = length/2
  var midNode = startNode
  var i = 0
  while i < mid, let next = midNode.next {
    midNode = next
    i += 1
  }
  let l2 = midNode.next
  midNode.next = nil
  let split1 = split_logn(startNode)
  let split2 = split_logn(l2)
  return merge(l1: split1, l2: split2)
}

func merge(l1: ListNode?, l2: ListNode?) -> ListNode? {
  guard let l1 = l1 else { return l2 }
  guard let l2 = l2 else { return l1 }
  
  if l1.val < l2.val {
    l1.next = merge(l1: l1.next, l2: l2)
    return l1
  } else {
    l2.next = merge(l1: l1, l2: l2.next)
    return l2
  }
}

func getLength(_ head: ListNode?) -> Int {
  guard var current = head else { return 0 }
  var length = 1
  while let next = current.next {
    current = next
    length += 1
  }
  return length
}



let node1 = ListNode(5)
let node2 = ListNode(4)
let node3 = ListNode(3)
let node4 = ListNode(2)
let node5 = ListNode(1)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
let a = sortList(node1)
a?.val
a?.next?.val
a?.next?.next?.val
a?.next?.next?.next?.next?.next
