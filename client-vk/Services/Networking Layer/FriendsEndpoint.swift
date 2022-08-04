//
//  FriendsEndpoint.swift
//  client-vk
//
//  Created by Mac on 7/25/22.
//

import Foundation

enum FriendsEndpoint: Endpoint {
    
    case fetchFriends(offset:Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
        return "api.vk.com"
        }
      
    }
    
    var path: String {
        switch self {
        case .fetchFriends:
            return "/method/friends.get"
        }
    
    }
    
    var parametres: [URLQueryItem] {
        switch self {
        case .fetchFriends(offset: let offset):
            return [
                URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                URLQueryItem(name: "order", value: "name"),
                URLQueryItem(name: "count", value: "20"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "fields", value: "bdate, city, photo_100, country, photo_200_orig"),
                URLQueryItem(name: "v", value:  Session.shared.v),
                URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchFriends:
            return "GET"
        }
    }
}
