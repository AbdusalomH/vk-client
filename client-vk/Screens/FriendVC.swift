//
//  FriendVC.swift
//  client-vk
//
//  Created by Mac on 6/27/22.
//

import UIKit

struct Friend {
    let name = "name"
}

final class FriendVC: UIViewController {
    
    
    var friend: [Friend] = [Friend()]
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        
        return tableView
        
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        configureTableView()
        
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.pinToEdges(to: view)

    }
}

extension FriendVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID, for: indexPath) as! FriendsCell
        
        cell.configure(friend[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

}
