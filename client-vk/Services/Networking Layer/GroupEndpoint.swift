//
//  GroupEndpoint.swift
//  client-vk
//
//  Created by Mac on 8/2/22.
//

import Foundation


enum GroupEndpoint: Endpoint {
    
    case fetchGroups
    
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
        default:
            return "/method/groups.get"
        }
    }
    
    var parametres: [URLQueryItem] {
        switch self {
        case .fetchGroups: return [
                   URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                   URLQueryItem(name: "extended", value: "1"),
                   URLQueryItem(name: "count", value: "30"),
                   URLQueryItem(name: "v", value:  Session.shared.v),
                   URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
        ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchGroups:
            return "GET"
        }
    }
}

