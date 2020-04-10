//
//  Settings.swift
//  KVO-Project
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

// class monitoring for changes - must be KVO - compliant
@objc class Settings: NSObject {
  static var shared = Settings()
  // @objc dynamic var object are observable - must be marked in order to observe
  @objc dynamic var fontSize: Int
  @objc dynamic var iconName: String
  override private init() {
    fontSize = 17
    iconName = "sun.haze.fill"
  }
}
