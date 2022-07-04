//
//  GroupsVC.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit

class GroupsVC: UIViewController {
    
    var groups: [Group] = []
    var groupTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"
        
        view.backgroundColor = .gray
        configureGroupTable()
        
        let service = GroupsApi()
        service.fetchGroups { group in
            self.groups = group
            self.groupTable.reloadData()
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

extension GroupsVC: UITableViewDataSource, UITableViewDelegate {
    
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
