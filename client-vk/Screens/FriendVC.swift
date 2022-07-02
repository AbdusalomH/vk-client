//
//  FriendVC.swift
//  client-vk
//
//  Created by Mac on 6/27/22.
//

import UIKit



final class FriendVC: UIViewController {
    
    
    var service = FriendsApi()
    
    
    var friends: [Friend] = []
    
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
        
        service.fetchFriends { friends in
            self.friends = friends
            self.tableView.reloadData()
        }
 
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.pinToEdges(to: view)

    }
}

extension FriendVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID, for: indexPath) as! FriendsCell
        
        let friend = friends[indexPath.row]
        
        cell.configure(friend)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }

}
