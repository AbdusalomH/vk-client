//
//  GroupsVC.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit
import SkeletonView

class GroupsVC: UIViewController {
    
    var isShownSkeleton: Bool = false
    
    var groups: [Group] = []
    var groupTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"
        
        view.backgroundColor = .gray
        configureGroupTable()
        
        
        if !isShownSkeleton {
            groupTable.isSkeletonable = true
            groupTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.25))
            groupTable.startSkeletonAnimation()
            isShownSkeleton = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureReceivedData()
    }
    
    
    private func configureReceivedData() {
        let service = GroupsApi()
        
        if isShownSkeleton {
            service.fetchGroups { group in
                self.groupTable.stopSkeletonAnimation()
                self.groupTable.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.groups = group
                self.groupTable.reloadData()
            }
        }
    }
    
    private func configureGroupTable() {
        
        groupTable = UITableView()
        
        view.addSubview(groupTable)
        groupTable.register(GroupsCell.self, forCellReuseIdentifier: GroupsCell.reuseID)
        groupTable.delegate = self
        groupTable.dataSource = self
        groupTable.rowHeight = 70
        groupTable.pinToEdges(to: view)
    }
}

extension GroupsVC: UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseID, for: indexPath) as! GroupsCell
        let groupsRespons = groups[indexPath.row]
        cell.configureCell(groupsRespons)
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        GroupsCell.reuseID
    }
}
