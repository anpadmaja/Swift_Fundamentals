//: [Previous](@previous)

import Foundation

// Implementing a Pure Swift Observer Pattern
// Given the following, how would a BalanceManager tell its observers that the balance did change?

final class BalanceManager {
  var observers: [Observable]

  init() {
    observers = [Observable]()
  }
  
  var balance: Double = 20.0 {
    didSet{
      observers.forEach({ $0.updateBalance() })
    }
  }
}

protocol Observable {
  func updateBalance()
}

struct FirstObserver: Observable {
  func updateBalance() {
    print("updated balance for the first observer")
  }
}

struct SecondObserver: Observable {
  func updateBalance() {
    print("updated balance for the second observer")
  }
}

let b = BalanceManager()
b.balance = 30

protocol Ordered {
  func precedes(other: Self) -> Bool
}

class Search<T> where T: Comparable {
  
  func binarySearch<T: Ordered>(sortedKeys: [T], forKey k: T) -> Int {
    var lo = 0, hi = sortedKeys.count
    while hi > lo {
      let mid = lo + (hi - lo) / 2
      if sortedKeys[mid].precedes(other: k) { lo = mid + 1 }
      else { hi = mid }
    }
    return lo
  }
}

class Number: Ordered {
  var value: Double = 0
  
  func precedes(other: Number) -> Bool {
    return value < other.value
  }
}

protocol Renderer {
  func move(to position: CGPoint)
  func line(to position: CGPoint)
  func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)
}

protocol Drawable {
  func draw(into renderer: Renderer)
}

struct Polygon: Drawable {
  func draw(into renderer: Renderer) {
    renderer.move(to: corners.last!)
    for p in corners { renderer.line(to: p) }
  }
  var corners: [CGPoint] = []
}

struct Circle : Drawable {
  func draw(into renderer: Renderer) {
    renderer.arc(at: center, radius: radius, startAngle: 0.0, endAngle: twoPi)
  }
  var center: CGPoint
  var radius: CGFloat
}

struct Diagram: Drawable {
  var elements: [Drawable] = []
  func draw(into renderer: Renderer) {
    for e in elements {
      e.draw(into: renderer)
    }
  }
}

