//
//  ViewController.swift
//  KVO-Lab
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class CreateNewUserController: UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var walletAmountTextField: UITextField!
  @IBOutlet weak var welcomeLabel: UILabel!
  
  private var greetingObservation: NSKeyValueObservation?
  
  private var userName: String!
  private var walletAmount: Int!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    textfieldSetup()
    configureGreeting()
  }
  
  private func textfieldSetup() {
    usernameTextField.delegate = self
    walletAmountTextField.delegate = self
  }
  
  private func configureGreeting() {
    greetingObservation = User.shared.observe(\.name, options: [.new], changeHandler: { (user, change) in
      guard let user = change.newValue else { return }
      self.welcomeLabel.text = "Welcome \(user)"
    })
  }
  
  

  @IBAction func createUserButton(_ sender: UIButton) {
    guard let name = usernameTextField.text,
      let amount = walletAmountTextField.text else {
        return
    }
//    guard let walletAmount = Int(amount) else { return }
    
//    let user = User(name: name, walletAmount: amount)
    
    let user = User.shared.createUser(name: name, walletAmount: amount)
    welcomeLabel.text = "\(user?.name ?? "") has $\(user?.walletAmount ?? 0)"
    print("\(user?.name ?? "") has $\(user?.walletAmount ?? 0)")
  }
  
}

extension CreateNewUserController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
