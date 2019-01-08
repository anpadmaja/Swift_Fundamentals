//: [Previous](@previous)

import Foundation

protocol BaseNotification {
  var id: Int { get }
  func notificationReceived()
  func isEqualTo(_ other: BaseNotification) -> Bool
}

extension BaseNotification where Self: Equatable {
  func isEqualTo(_ other: BaseNotification) -> Bool {
    print("***** isEqualTo in BaseNotification extension")
    guard let otherN = other as? Self else { return false }
    return otherN == self
  }
}

struct AnyEqutableNotification: BaseNotification, Equatable {
  private var baseNotification: BaseNotification
  init(notification: BaseNotification) {
    self.baseNotification = notification
  }
  var id: Int {
    return baseNotification.id
  }
  func notificationReceived() {
    baseNotification.notificationReceived()
  }
  public static func ==(lhs: AnyEqutableNotification, rhs: AnyEqutableNotification) -> Bool {
    print("***** == in \(self) extension")
    return lhs.baseNotification.isEqualTo(rhs.baseNotification)
  }
}

class Notification {
  var array: [BaseNotification]
  
  init() {
    array = [BaseNotification]()
  }
  
  func sub(obj: BaseNotification) {
    print("appending \(obj) in the array")
    array.append(obj)
  }
  
  func unSub(obj: BaseNotification) {
    for (index,value) in array.enumerated() {
      print("inside unsubscribe \(obj)")
      if value.isEqualTo(obj) {
        array.remove(at: index)
      }
    }
  }
  
  func notify() {
    for obj in array {
      obj.notificationReceived()
    }
  }
}

class ViewController: BaseNotification, Equatable {
  var id: Int
  var color: String

  init(id: Int, color: String) {
    self.id = id
    self.color = color
  }
  
  static func == (lhs: ViewController, rhs: ViewController) -> Bool {
    print("inside == func in the ViewController lhs rhs")
    return lhs.id == rhs.id && lhs.color == rhs.color
  }
  
  func notificationReceived() {
    print("do something class A")
  }
}

let notificationInstance = Notification()
let vc1 = AnyEqutableNotification(notification: ViewController(id: 1, color: "Black"))
let vc2 = AnyEqutableNotification(notification: ViewController(id: 2, color: "Black"))
notificationInstance.sub(obj: vc1)
notificationInstance.sub(obj: vc2)
notificationInstance.notify()
notificationInstance.unSub(obj: vc2)
