//
//  AccountViewController.swift
//  KVO-Lab
//
//  Created by Eric Davenport on 4/10/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var accountBalanceLabel: UILabel!
  @IBOutlet weak var depositTextField: UITextField!
  
  private var user: User?
  
  init?(coder: NSCoder, user: User) {
    self.user = user
    super.init(coder: coder)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder: has not neen implemented")
  }

  
    override func viewDidLoad() {
        super.viewDidLoad()
      updateUI()
    }
  
  private func updateUI() {
    userNameLabel.text = "User\n\(user?.name ?? "")"
    accountBalanceLabel.text = "Account Balance\n$\(user?.walletAmount ?? 0).00"
  }
    
  @IBAction func withdrawalButtonBressed(_ sender: UIButton) {
    
  }
  
  @IBAction func depositButtonPressed(_ sender: UIButton) {
    
  }
  

}
