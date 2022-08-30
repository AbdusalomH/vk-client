//
//  GroupsVC.swift
//  client-vk
//
//  Created by Mac on 6/28/22.
//

import UIKit
import SkeletonView


class GroupsVC: UIViewController {
    
    private var viewModel = ViewModel()

    
    lazy var groupTable: UITableView = {
        
        let tabelView = UITableView()
        tabelView.register(GroupsCell.self, forCellReuseIdentifier: GroupsCell.reuseID)
        tabelView.delegate                                       = self
        tabelView.dataSource                                     = self
        tabelView.separatorStyle                                 = .none
        tabelView.rowHeight                                      = UITableView.automaticDimension
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
        if !viewModel.isShownSkeleton {
            groupTable.isSkeletonable = true
            groupTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray), animation: nil, transition: .crossDissolve(0.5))
            groupTable.startSkeletonAnimation()
            viewModel.isShownSkeleton = true
        }
    }
    
    
    private func fetchGroups() {
        
        if viewModel.isShownSkeleton {
            viewModel.fetchGroup {
                self.groupTable.stopSkeletonAnimation()
                self.groupTable.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.groupTable.reloadData()
                    
            } failure: { err in
                print(err)
            }
        }
    }
}

extension GroupsVC: UITableViewDataSource, UITableViewDelegate, SkeletonTableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.filteredGroup.isEmpty {
            return viewModel.filteredGroup.count
        } else {
            return viewModel.groups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseID, for: indexPath) as! GroupsCell
        let groupsRespons = viewModel.groups[indexPath.row]

        if !viewModel.filteredGroup.isEmpty {
            let filteredResponse = self.viewModel.filteredGroup[indexPath.row]
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
        
        if !viewModel.filteredGroup.isEmpty {
            let selectedGroup = viewModel.filteredGroup[indexPath.row]
            print(selectedGroup.id)
            let groupDetail = UINavigationController(rootViewController:  GroupsDetailsVC(title: selectedGroup.name, image: selectedGroup.photo200, id: -selectedGroup.id))
            if let groupSheetMenu = groupDetail.sheetPresentationController {
                
                groupSheetMenu.detents = [.medium(), .large()]
                groupSheetMenu.prefersGrabberVisible = true
                groupSheetMenu.preferredCornerRadius = 12
                groupSheetMenu.prefersScrollingExpandsWhenScrolledToEdge = true
                
            }
            present(groupDetail, animated: true)
            
        } else {
            
            let selectedGroup = viewModel.groups[indexPath.row]
            print(selectedGroup.id)
            let groupDetail = UINavigationController(rootViewController:  GroupsDetailsVC(title: selectedGroup.name, image: selectedGroup.photo200, id: (-selectedGroup.id)))
            if let groupSheetMenu = groupDetail.sheetPresentationController {
                
                groupSheetMenu.detents = [.medium(), .large()]
                groupSheetMenu.prefersGrabberVisible = true
                groupSheetMenu.preferredCornerRadius = 12
                groupSheetMenu.prefersScrollingExpandsWhenScrolledToEdge = true
                
            }
            present(groupDetail, animated: true)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GroupsVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {return}
        viewModel.filteredGroup = viewModel.groups.filter({$0.name.lowercased().contains(text.lowercased())})
        groupTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filteredGroup.removeAll()
        groupTable.reloadData()
    }
}

