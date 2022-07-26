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
    
    lazy var groupTable: UITableView = {
        
        let tabelView = UITableView()
        tabelView.register(GroupsCell.self, forCellReuseIdentifier: GroupsCell.reuseID)
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.rowHeight = 70
        return tabelView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController                                     = UISearchController()
        searchController.searchResultsUpdater                    = self
        searchController.searchBar.delegate                      = self
        searchController.searchBar.placeholder                   = "Search for a group"
        searchController.obscuresBackgroundDuringPresentation    = false
        searchController.becomeFirstResponder()
        return searchController
    }()
    
    
    var searchResults: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupContraints()
        setupSkeleton()
        fetchGroups()
        
    }
    
    private func setupViews() {
        title = "Groups"
        view.backgroundColor = .gray
        navigationItem.searchController = searchController
        view.addSubview(groupTable)
        
    }
    
    private func setupContraints() {
        groupTable.pinToEdges(to: view)
    }
    
    
    func setupSkeleton() {
        if !isShownSkeleton {
            groupTable.isSkeletonable = true
            groupTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.5))
            groupTable.startSkeletonAnimation()
            isShownSkeleton = true
        }
    }
    
    
    private func fetchGroups() {
        
    let service = GroupsApi()
        
        if isShownSkeleton {
            service.fetchGroups { result in
                switch result {
                case .success(let groups):
                    self.groupTable.stopSkeletonAnimation()
                    self.groupTable.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.groups = groups
                    self.groupTable.reloadData()
                    
                case .failure(let error):
                    self.presentAlert(title: "Something went wrong", body: error.rawValue, button: "OK")
                    print(error.rawValue)
                }
            }
        }
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
