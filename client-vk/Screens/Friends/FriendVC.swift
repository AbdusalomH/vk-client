//
//  FriendVC.swift
//  client-vk
//
//  Created by Mac on 6/27/22.
//


import UIKit
import SkeletonView


final class FriendVC: UIViewController {

    private var viewModel = FriendsViewModel()
    
    lazy var friendsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControll
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        return tableView
    }()
    
    lazy var refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupViews()
        setupConstraints()
        setupSkeleton()
        fetchFriends(offset: 0)
    }
    
    private func setupViews() {
        title = "F r i e n d s"
        view.addSubview(friendsTableView)
        friendsTableView.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        friendsTableView.pinToEdges(to: view)
    }

    
    private func setupSkeleton() {
        if !viewModel.isAddedToSkeleton {
            self.friendsTableView.isSkeletonable = true
            self.friendsTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor.gray), animation: nil, transition: .crossDissolve(0.5))
            self.friendsTableView.startSkeletonAnimation()
            self.viewModel.isAddedToSkeleton = true
        }
    }
    
    
    func fetchFriends(offset: Int = 0) {
        
        if viewModel.isAddedToSkeleton {
            viewModel.fetchFriends(offset: offset) {
                self.friendsTableView.stopSkeletonAnimation()
                self.friendsTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.friendsTableView.reloadData()
                
            } failure: { err in
                
                self.presentAlert(title: "Warning", body: err.localizedDescription, button: "Ok")
            }
        }
    }
    
    
    @objc
    func pullToRefreshAction() {
        fetchFriends()
        refreshControll.endRefreshing()
    }
}



extension FriendVC: UITableViewDelegate, SkeletonTableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID, for: indexPath) as! FriendsCell
        let friend = viewModel.friends[indexPath.row]
        cell.configure(friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return FriendsCell.reuseID
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userinfo = UserInfoVC(userInfo: viewModel.friends[indexPath.row])
        navigationController?.pushViewController(userinfo, animated: true)
    }
}


extension FriendVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            let maxNumber = indexPaths.map({$0.last ?? 0}).max() ?? 0
        
        if maxNumber > viewModel.friends.count - 5, viewModel.isReqestingFriends == false {
                viewModel.isReqestingFriends = true
                fetchFriends(offset: maxNumber)
            }
    }
}
    

