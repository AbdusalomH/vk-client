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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
    
    var numberoFriends = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupSkeleton()
        fetchFriends(offset: numberoFriends)
        
    }
    
    private func setupViews() {
        //title = "F r i e n d s"
        view.addSubview(friendsTableView)
        view.backgroundColor = .white
        friendsTableView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        //friendsTableView.pinToEdges(to: view)
        NSLayoutConstraint.activate([
            friendsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    private func setupSkeleton() {
        if !viewModel.isAddedToSkeleton {
            self.friendsTableView.isSkeletonable = true
            self.friendsTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor.gray), animation: nil, transition: .crossDissolve(0.5))
            self.friendsTableView.startSkeletonAnimation()
            self.viewModel.isAddedToSkeleton = true
        }
    }
    
    
    func fetchFriends(offset: Int) {
        
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
    
    func fetchNextFriends(offset: Int) {
        viewModel.fetchFriends(offset: offset) {
            self.friendsTableView.stopSkeletonAnimation()
            self.friendsTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
            self.friendsTableView.reloadData()
            
        } failure: { err in
            
            self.presentAlert(title: "Warning", body: err.localizedDescription, button: "Ok")
        }
    }
    
    
    @objc
    func pullToRefreshAction() {
        fetchFriends(offset: numberoFriends)
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension FriendVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let maxNumber = indexPaths.map({$0.last ?? 0}).max() ?? 0
        
        
        if maxNumber > viewModel.friends.count - 3, viewModel.isReqestingFriends == false {
                fetchNextFriends(offset: maxNumber)
        }
    }
}
    

