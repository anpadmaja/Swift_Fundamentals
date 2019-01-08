//: [Previous](@previous)

import Foundation

protocol OwnerDelegate: class {
  func washClothes()
  func waterPlants()
  func cleanHouse()
}

class Person: OwnerDelegate, Equatable {

  var name: String
  var phoneNumber: String
  var ownersName: String
  
  init(name: String, ph: String, ownersName: String) {
    self.name = name
    self.phoneNumber = ph
    self.ownersName = ownersName
  }

  func washClothes() {
    print("\(name) is washing the clothes")
  }
  
  func waterPlants() {
    print("\(name) is watering the plants")
  }
  
  func cleanHouse() {
    print("\(name) is cleaning the house")
  }

  public static func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.phoneNumber == rhs.phoneNumber
  }
}

class Owner: Equatable {
  var name : String
  
  init(name : String) {
    self.name = name
  }
  
  weak var delegate: OwnerDelegate?

  func giveCommand() {
    delegate?.waterPlants()
  }
  
  public static func ==(lhs: Owner, rhs: Owner) -> Bool {
    return lhs.name == rhs.name
  }
}

let a = Person(name: "nink", ph: "76864574764", ownersName: "loipt")
let f = Owner(name: "loipt")
f.delegate = a
f.giveCommand()
