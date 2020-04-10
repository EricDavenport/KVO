//
//  UserInfoController.swift
//  KVO-Lab
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class UserInfoController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var userObservation: NSKeyValueObservation?
  
  private var users = [User]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    loadTableView()
  }
  
  private func loadTableView() {
    userObservation = UserObject.shared.observe(\.users, options: [.new], changeHandler: { [weak self] (user, change) in
      print("inside of UserInfoController observer")
      guard let newUsers = change.newValue else { return }
      self?.users = newUsers
    })
    
  }
  
}


extension UserInfoController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
    let user = users[indexPath.row]
    
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = "Account balance: $\(user.walletAmount).00"
    return cell
  }
  
  
}

extension UserInfoController : UITableViewDelegate {
  
}
