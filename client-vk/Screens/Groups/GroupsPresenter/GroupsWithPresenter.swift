//
//  GroupsWithPresenter.swift
//  client-vk
//
//  Created by Mac on 7/13/22.
//

import UIKit

class GroupsWithPresenter: UIViewController, GroupPresentProtocol {

    let groupPresent = GroupPresenter()
    
    let refresh = UIRefreshControl()

    var groups: [Group] = []
    var groupTable: UITableView!
    
    func presentGroup(GroupsResponse: [Group]) {
        groups = GroupsResponse
        DispatchQueue.main.async {
            self.groupTable.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups2"
        configureGroupTable()
        getGroupsViaPresenter()
        refreshGroupTable()
    }
    
    func refreshGroupTable() {
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        groupTable.refreshControl = refresh
    }
    
    @objc func refreshTable() {
        groupPresent.getGroups()
        groupTable.refreshControl?.endRefreshing()
    }
    
    private func getGroupsViaPresenter() {
        groupPresent.delegate = self
        groupPresent.getGroups()
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

extension GroupsWithPresenter: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseID, for: indexPath) as! GroupsCell
        let groupsRespons = groups[indexPath.row]
        cell.configureCell(groupsRespons)
        return cell
    }
}

