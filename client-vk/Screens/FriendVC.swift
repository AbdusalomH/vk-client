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
    
    let service = FriendsApi()
        
    var friends: [Friend] = []
    
    var isReqestingFriends: Bool = false
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "F r i e n d s"
        
        configureTableView()
        showSkeleton()
        configureRefreshTable()
        
    }
    
    func configureRefreshTable() {
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(refresh)
        tableView.refreshControl = refresh
        fetchData()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    
    func fetchData(offset: Int = 0) {
        
        if isAddedToSkeleton {
            
            service.fetchFriends(offset: offset) { [weak self] result in
                
                guard let self = self else {return}
                
                self.isReqestingFriends = false
                
                switch result {
                    
                case  .success(let friends):
                    if offset == 0 {
                        self.friends = friends
                        self.tableView.stopSkeletonAnimation()
                        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                        self.tableView.reloadData()
                        return
                    }
                    
                    self.friends.append(contentsOf: friends)
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
        tableView.backgroundColor = .systemBackground
        
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


extension FriendVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            let maxNumber = indexPaths.map({$0.last ?? 0}).max() ?? 0
        
            if maxNumber > friends.count - 5, isReqestingFriends == false {
                isReqestingFriends = true
                fetchData(offset: maxNumber)
            }
    }
}
    

