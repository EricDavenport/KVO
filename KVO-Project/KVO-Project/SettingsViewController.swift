//
//  SettingsViewController.swift
//  KVO-Project
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var fontSizeLabel: UILabel!
  @IBOutlet weak var pickerView: UIPickerView!
  
  // create observer to change font size
  private var fontSizeObservation: NSKeyValueObservation?
  
  // datat for the picker view
  private let iconNames = ["sun.haze.fill", "moon", "globe", "icloud"] // SFSymbol image names e.g moon
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurePickerView()
    configureFontSize()
  }
  
  private func configurePickerView() {
    pickerView.delegate = self
    pickerView.dataSource = self
  }
  
  private func configureFontSize() {
    // observer is making observations and is makes changes within completion changler
    fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      // inside completion handler
      guard let newSize = change.newValue else { return }
      self?.fontSizeLabel.text = newSize.description
    })
  }
  
  
  @IBAction func sliderChanged(_ sender: UISlider) {
    let newSize = Int(sender.value) // cast Float to Int as our setting font size is an Int
    Settings.shared.fontSize = newSize   // sets the font size to the slider value
    
    // after setting the fontsize on the setting class thre welocme controller will be updated via the KVO observer
  }
  
  
}

extension SettingsViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1  // number of columns
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return iconNames.count  // number of rows
  }
}

extension SettingsViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return iconNames[row]   // indexPath.row
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let iconName = iconNames[row]
    Settings.shared.iconName = iconName  // sending information to setting observable field
    

  }
}
