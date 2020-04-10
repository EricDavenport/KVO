//
//  ViewController.swift
//  KVO-Project
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  
  private var fontSizeObservation: NSKeyValueObservation?
  private var iconNameObservation: NSKeyValueObservation?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureObservers()
    // Do any additional setup after loading the view.
  }
  
  private func configureObservers() {
    configureFontSizeObservation()
    configureNameIconObservation()
  }
  
  
  private func configureFontSizeObservation() {
    fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      
      guard let newSize = change.newValue else { return }
      // update UI for font
      let fontSize = CGFloat(newSize)
      self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
    })
  }
  
  private func configureNameIconObservation() {
    iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      guard let iconName = change.newValue else { return }
      self?.iconImageView.image = UIImage(systemName: iconName)
    })
  }
  
  // stops the observer
  deinit {  // gets called when the object is no longer in memory
    fontSizeObservation?.invalidate()       // .invalidate - use to get observer to stop observing
    iconNameObservation?.invalidate()
  }


}

