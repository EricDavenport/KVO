//
//  DepositController.swift
//  KVO-Lab
//
//  Created by Eric Davenport on 4/7/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class DepositController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  private var depositObservation:  NSKeyValueObservation?
  
  private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      loadTableView()
    }
    
  private func loadTableView() {
    depositObservation = UserObject.shared.observe(\.users, options: [.new], changeHandler: { [weak self] (user, change) in
      print("inside of DepositController observer")
      guard let newUsers = change.newValue else { return }
      self?.users = newUsers
      self?.tableView.reloadData()
    })
    
  }
}


extension DepositController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "depositCell", for: indexPath)
    let user = users[indexPath.row]
    
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = "Account balance: $\(user.walletAmount).00"
    return cell
  }
  
}

extension DepositController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]
    print("\(user.name) cell pressed")
    
    guard let accountView = storyboard?.instantiateViewController(identifier: "AccountViewController", creator: { (coder) in
      return AccountViewController(coder: coder, user: user)
    }) else {
      fatalError("could not downcast to AccountViewController")
    }
    
    accountView.modalPresentationStyle = .formSheet
    present(accountView, animated: true)
  }
}
