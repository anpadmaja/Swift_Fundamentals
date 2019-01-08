//: [Previous](@previous)

import Foundation

class BinaryNode<T: Comparable> : Comparable {
  static func < (lhs: BinaryNode<T>, rhs: BinaryNode<T>) -> Bool {
    return lhs.data < rhs.data
  }
  
  var data: T
  var leftNode: BinaryNode<T>?
  var rightNode: BinaryNode<T>?
  
  init(data: T, leftNode: BinaryNode<T>? = nil, rightNode: BinaryNode<T>? = nil) {
    self.data = data
    self.leftNode = leftNode
    self.rightNode = rightNode
  }
  
  static func ==(lhs: BinaryNode<T>, rhs: BinaryNode<T>) -> Bool {
    return lhs.data == rhs.data
  }
  
  var isLeaf: Bool {
    return leftNode == nil && rightNode == nil
  }
  
  var hasLeftChild: Bool {
    return leftNode != nil
  }
  
  var hasRightChild: Bool {
    return leftNode != nil
  }
}

func numberOfLeaves(root: BinaryNode<Int>?) -> Int {
  guard let current = root else { return 0 }
  if current.isLeaf { return 1 }
  let left = numberOfLeaves(root: current.leftNode)
  let right = numberOfLeaves(root: current.rightNode)
  return left + right
}

class BinarySearchTree<T : Comparable> {
  
  private var root: BinaryNode<T>?
  private var leftSubTree: BinarySearchTree<T>?
  private var rightSubTree: BinarySearchTree<T>?
  
  init() {
    self.root = nil
    leftSubTree = nil
    rightSubTree = nil
  }
  
  init(data: T) {
    root = BinaryNode(data: data)
  }
  
  init(rootNode: BinaryNode<T>) {
    root = rootNode
  }
  
  var getRootNode: BinaryNode<T>? {
    return root
  }
  
  var isEmpty: Bool {
    return root == nil
  }
  
  func heightOfBST(_ root: BinaryNode<T>?) -> Int {
    guard let root = root else { return 0 }
    return 1 + max(heightOfBST(root.leftNode), heightOfBST(root.rightNode))
  }
  
  func numberOfNodes() -> Int {
    guard let currentNode = root else { return 0 }
    return numberOfNodes(root: currentNode)
  }
  
  private func numberOfNodes(root: BinaryNode<T>?) -> Int {
    guard let root = root else { return 0 }
    return 1+numberOfNodes(root: root.leftNode)+numberOfNodes(root: root.rightNode)
  }
  
  func add(data: T) -> BinaryNode<T> {
    let currentRoot = self.root
    return add(root: currentRoot, data: data)
  }
  
  func add(root: BinaryNode<T>?, data: T) -> BinaryNode<T> {
    guard let currentRoot = root else {
      let newNode = BinaryNode(data: data)
      return newNode
    }
    if data < currentRoot.data {
      let newNode = add(root: currentRoot.leftNode, data: data)
      currentRoot.leftNode = newNode
    } else {
      let newNode = add(root: currentRoot.rightNode, data: data)
      currentRoot.rightNode = newNode
    }
    return currentRoot
  }
  
  func remove(data: T) {
    remove(root: &self.root, data: data)
  }

  func remove(root: inout BinaryNode<T>?, data: T) {
    guard let current = root else { return }
    if !current.isLeaf {
      if root!.data == data {
        removeEntry(curr: &root, data: data)
      } else if root!.data < data {
        remove(root: &root!.rightNode, data: data)
      } else {
        remove(root: &root!.leftNode, data: data)
      }
    } else {
      if root!.data == data {
        removeEntry(curr: &root, data: data)
      }
    }
  }

  private func removeEntry(curr: inout BinaryNode<T>?, data: T) {
    guard let current = curr else { return }
    if current.isLeaf {
      curr = nil
    }
    else if current.hasLeftChild && current.hasRightChild {
      guard let largest = findLargest(root: current.leftNode) else { return }
      if largest.hasLeftChild {
        current.data = largest.data
        largest.data = largest.leftNode!.data
        largest.leftNode = nil
      }
    }
    else if current.hasLeftChild || current.hasRightChild {
      if current.hasRightChild, let rightChild = current.rightNode {
        current.data = rightChild.data
        current.rightNode = nil
      } else if current.hasLeftChild, let leftChild = current.leftNode {
        current.data = leftChild.data
        current.leftNode = nil
      }
    }
  }
  
  func findLargest(root: BinaryNode<T>?) ->  BinaryNode<T>? {
    guard let current = root else { return root }
    if let val = findLargest(root: current.rightNode) {
      return max(val, current)
    }
    return current
  }
  
  func updateData(oldData: T, newData: T) -> T {
    return updateData(root: self.root, oldData: oldData, newData: newData)
  }
  
  func updateData(root: BinaryNode<T>?, oldData: T, newData: T) -> T {
    guard let curr = root else { return oldData }
    if curr.data == oldData {
      curr.data = newData
    } else if curr.data < oldData {
      updateData(root: curr.rightNode, oldData: oldData, newData: newData)
    } else {
      updateData(root: curr.leftNode, oldData: oldData, newData: newData)
    }
    return curr.data
  }
  
  func findSmallest(root: BinaryNode<T>?) ->  BinaryNode<T>? {
    guard let current = root else { return root }
    if let val = findSmallest(root: current.leftNode) {
      return min(val, current)
    }
    return current
  }

  func inorderTranversal() {
    let currentRoot = self.root
    inorderTranversal(root: currentRoot)
  }
  
  func inorderTranversal(root: BinaryNode<T>?) {
    guard let curr = root else { return }
    inorderTranversal(root: curr.leftNode)
    print(curr.data)
    inorderTranversal(root: curr.rightNode)
  }
}

//let a = BinaryNode<Int>(data: 8)
//let b = BinaryNode<Int>(data: 4)
//let e = BinaryNode<Int>(data: 16)
//let c = BinaryNode<Int>(data: 3)
//let d = BinaryNode<Int>(data: 5)
//
//let tree = BinarySearchTree<Int>(rootNode: a)
//tree.isEmpty
//let root = tree.getRootNode
//root?.leftNode = b
//root?.rightNode = e
//tree.add(data: 3)
//tree.add(data: 5)
//tree.add(data: 6)
//
//
//tree.numberOfNodes()
//tree.inorderTranversal(root: a)
//tree.heightOfBST(a)
//
//tree.findLargest(root: a)?.data
//tree.findLargest(root: root?.leftNode)?.data
//tree.findSmallest(root: a)?.data
//tree.findSmallest(root: root?.leftNode)?.data

func consecutiveNumbersSum(_ num: Int) -> Int {
  var count = 1
  var currentSum = 0
  let numFloat: Float = Float(num)
  let numNew: Int = Int(ceil(numFloat/2))
  
  for i in stride(from:1, through: numNew, by:1) {
    currentSum = i
    
    for j in stride(from:i+1, through: numNew, by:1) {
      currentSum += j
      if currentSum == num { count += 1 }
      else if currentSum > num {
        break
      }
    }
  }
  return count
}

//consecutiveNumbersSum(5)

var sum = 0
func sumOfLeftLeaves(_ root: BinaryNode<Int>?) -> Int {
  guard let current = root else { return 0 }
  if current.isLeaf {
    return current.data
  } else {
    sum += sumOfLeftLeaves(current.leftNode)
    sumOfLeftLeaves(current.rightNode)
  }
  return sum
}

let a = BinaryNode<Int>(data: 8)
let b = BinaryNode<Int>(data: 4)
let e = BinaryNode<Int>(data: 16)
let c = BinaryNode<Int>(data: 3)
let d = BinaryNode<Int>(data: 5)

a.leftNode = b
a.rightNode = e
b.leftNode = c
b.rightNode = d

let tree = BinarySearchTree<Int>(rootNode: a)
tree.remove(data: 8)


class Bnode {
  var data: Int
  var left: Bnode?
  var right : Bnode?
  
  init(data: Int) {
    self.data = data
    left = nil
    right = nil
  }
  
  var isLeaf: Bool {
    return left == nil && right == nil
  }
  
  func numberOfLeaves() -> Int {
    if self.isLeaf { return 1 }
    return (left?.numberOfLeaves() ?? 0) + (right?.numberOfLeaves() ?? 0)
  }
}

let bnode1 = Bnode(data: 1)
let bnode3 = Bnode(data: 3)
let bnode2 = Bnode(data: 2)

bnode1.left = bnode2
bnode1.right = bnode3
bnode3.left = Bnode(data: 4)
bnode3.right = Bnode(data: 4)

bnode1.numberOfLeaves()

class Node {
  var value: Int
  var children: [Node]?
  
  init(value: Int, _ children: [Node]?) {
    self.value = value
    self.children = children
  }
  
  func preorder() {
    print(self.value)
    guard let children = self.children else { return }
    for child in children {
      child.preorder()
    }
  }
}

func preorder(node: Node?) {
  guard let current = node else { return }
  print(current.value)
  guard let children = current.children else { return }
  for child in children {
    preorder(node: child)
  }
}

let node1 = Node(value: 1, nil)
let node2 = Node(value: 3, nil)
let node3 = Node(value: 2, nil)
let children = [node1, node2, node3]

let mom = Node(value: 0, children)
//preorder(node: mom)
mom.preorder()

class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(val: Int) {
    self.val = val
  }
}

func isLeaf(root: TreeNode) -> Bool {
  if root.left == nil && root.right == nil {
    return true
  } else {
    return false
  }
}

func findLeaves(_ root: TreeNode?) -> [[Int]] {
  var rootNode = root
  var leavesByLayer = [[Int]]()
  while(rootNode != nil) {
    var returnArray = [Int]()
    findLeavesByLayer(root: &rootNode, returnArray: &returnArray)
    leavesByLayer.append(returnArray)
  }
  return leavesByLayer
}

func findLeavesByLayer(root: inout TreeNode?, returnArray: inout [Int]) {
  guard let current = root else { return }
  if isLeaf(root: current) {
    returnArray.append(current.val)
    root = nil
    return
  }
  findLeavesByLayer(root: &current.left, returnArray: &returnArray)
  findLeavesByLayer(root: &current.right, returnArray: &returnArray)
}
