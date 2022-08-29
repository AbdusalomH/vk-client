//
//  FriendsViewModel.swift
//  client-vk
//
//  Created by Mac on 8/2/22.
//

import Foundation

final class FriendsViewModel {
    

    var isAddedToSkeleton: Bool = false

    let service = FriendsApi()
        
    var friends: [Friend] = []
    
    var isReqestingFriends: Bool = false
    
    func fetchFriends(offset: Int = 0, success: @escaping ()->(), failure: @escaping (Error) -> ()) {
        Api.request(endpoint: FriendsEndpoint.fetchFriends(offset: offset), responseModel: FriendResponse.self) { result in
            
            switch result {
            case .success(let friends):
                self.friends.append(contentsOf: friends.items)
                success()
                return
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
}
