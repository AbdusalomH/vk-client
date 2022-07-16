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
    var filteredGroup: [Group] = []
    
    var groupTable: UITableView!
    
    
    var searchResults: [Group] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"
        
        view.backgroundColor = .gray
        configureGroupTable()
        configureSearchController()
        getGroupData()
        configureReceivedData()
        configureSearchController()
        
    }
    
    private func configureSearchController() {
        let searchController                                     = UISearchController()
        searchController.searchResultsUpdater                    = self
        searchController.searchBar.delegate                      = self
        searchController.searchBar.placeholder                   = "Search for a group"
        searchController.obscuresBackgroundDuringPresentation    = false
        searchController.becomeFirstResponder()
        navigationItem.searchController                          = searchController
    }
    
    
    func getGroupData() {
        if !isShownSkeleton {
            groupTable.isSkeletonable = true
            groupTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.25))
            groupTable.startSkeletonAnimation()
            isShownSkeleton = true
        }
    }
    
    
    private func configureReceivedData() {
        
    let service = GroupsApi()
        
        if isShownSkeleton {
            service.fetchGroups { result in
                switch result {
                case .success(let groups):
                    self.groupTable.stopSkeletonAnimation()
                    self.groupTable.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                    self.groups = groups
                    self.groupTable.reloadData()
                    
                case .failure(let error):
                    self.presentAlert(title: "Something went wrong", body: error.rawValue, button: "OK")
                    print(error.rawValue)
                }
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

extension GroupsVC: UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredGroup.isEmpty {
            return filteredGroup.count
        } else {
            return groups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseID, for: indexPath) as! GroupsCell
        let groupsRespons = groups[indexPath.row]

        if !filteredGroup.isEmpty {
            let filteredResponse = self.filteredGroup[indexPath.row]
            cell.configureCell(filteredResponse)
        } else {
            cell.configureCell(groupsRespons)
        }
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        GroupsCell.reuseID
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !filteredGroup.isEmpty {
            let selectedGroup = filteredGroup[indexPath.row]
            let groupDetail = UINavigationController(rootViewController:  GroupsDetailsVC(title: selectedGroup.name, image: selectedGroup.photo200))
            if let groupSheetMenu = groupDetail.sheetPresentationController {
                
                groupSheetMenu.detents = [.medium(), .large()]
                groupSheetMenu.prefersGrabberVisible = true
                groupSheetMenu.preferredCornerRadius = 12
                groupSheetMenu.prefersScrollingExpandsWhenScrolledToEdge = true
                
            }
            present(groupDetail, animated: true)
            
        } else {
            
            let selectedGroup = groups[indexPath.row]
            
            let groupDetail = UINavigationController(rootViewController:  GroupsDetailsVC(title: selectedGroup.name, image: selectedGroup.photo200))
            if let groupSheetMenu = groupDetail.sheetPresentationController {
                
                groupSheetMenu.detents = [.medium(), .large()]
                groupSheetMenu.prefersGrabberVisible = true
                groupSheetMenu.preferredCornerRadius = 12
                groupSheetMenu.prefersScrollingExpandsWhenScrolledToEdge = true
                
            }
            present(groupDetail, animated: true)
        }
    }
}

extension GroupsVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {return}
        filteredGroup = groups.filter({$0.name.lowercased().contains(text.lowercased())})
        groupTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredGroup.removeAll()
        groupTable.reloadData()
    }
}
