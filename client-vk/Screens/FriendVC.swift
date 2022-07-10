//
//  FriendVC.swift
//  client-vk
//
//  Created by Mac on 6/27/22.
//

import UIKit
import SkeletonView



final class FriendVC: UIViewController {

    var isAddedToSkeleton: Bool = false
    
    let refresh = UIRefreshControl()
        
    var friends: [Friend] = []
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "F r i e n d s"
        configureTableView()
        showSkeleton()
        
        
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(refresh)
        tableView.refreshControl = refresh
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    @objc func refreshTable() {
        fetchData()
        refresh.endRefreshing()
    }
    
    func showSkeleton() {
        if !isAddedToSkeleton {
            self.tableView.isSkeletonable = true
            self.tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor.gray), animation: nil,transition: .crossDissolve(0.5))
            self.tableView.startSkeletonAnimation()
            self.isAddedToSkeleton = true
        }
    }
    
    
    func fetchData() {
        
        let service = FriendsApi()
        
        if isAddedToSkeleton {
            service.fetchFriends { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                    
                case  .success(let friends):
                    self.friends = friends
                    self.tableView.stopSkeletonAnimation()
                    self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.pinToEdges(to: view)
        tableView.backgroundColor = .white
        
    }
}

extension FriendVC: UITableViewDelegate, SkeletonTableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID, for: indexPath) as! FriendsCell
        let friend = friends[indexPath.row]
        cell.configure(friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return FriendsCell.reuseID
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userinfo = UserInfoVC(userInfo: friends[indexPath.row])
        navigationController?.pushViewController(userinfo, animated: true)
    }
}
