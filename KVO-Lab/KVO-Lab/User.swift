//
//  User.swift
//  KVO-Lab
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

@objc class UserObject: NSObject {
  static var shared = UserObject()
  @objc dynamic var users: [User]
  init(users: [User]) {
    self.users = users
    super.init()
  }
  override private init() {
    users = [User]()
  }
}

@objc class User: NSObject {
  static var shared = User()
  // observable object ks the user
  @objc dynamic var name: String
  @objc dynamic var walletAmount: Int
  
  init(name: String, walletAmount: Int) {
    self.name = name
    self.walletAmount = walletAmount
    super.init()
  }
  
  // necessary for shared var - allows for singleton
  override private init() {
    name = "no name"
    walletAmount = 0
  }
  
  @discardableResult
  public func createUser(name: String, walletAmount: String) -> User? {
    guard let amount = Int(walletAmount) else { return nil }
    let user = User(name: name, walletAmount: amount)
    UserObject.shared.users.append(user)
    return user
  }
  
  @discardableResult
  public func updateWallet(user: User, newValue: Int) -> User? {
    user.walletAmount = newValue
//    UserObject.shared.users.append(user)
    var users = UserObject.shared.users
    users.first(where: { $0.name == user.name })?.walletAmount = newValue
    return user
  }
  
}


/*
 array.first(where: { $0.eventID == id })?.added = value
 array.filter {$0.eventID == id}.first?.added = value
 */
