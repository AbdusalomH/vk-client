//
//  GroupsViewModel.swift
//  client-vk
//
//  Created by Mac on 8/4/22.
//

import Foundation

final class ViewModel {
    
    var isShownSkeleton: Bool = false
        
    var groups: [Group] = []
    var filteredGroup: [Group] = []
    
    func fetchGroup(success: @escaping ()->(), failure: @escaping (Error)->()) {
        Api.request(endpoint: GroupEndpoint.fetchGroups, responseModel: GroupResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let group):
                self.groups = group.items
                success()
            case .failure(let err):
                print(err)
                failure(err)
            }
        }
    }
}
