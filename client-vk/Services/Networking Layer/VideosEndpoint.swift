//
//  VideosEndpoint.swift
//  client-vk
//
//  Created by Mac on 8/4/22.
//

import Foundation

enum VideosEndpoint: Endpoint {
    
    case fetchVideos(offset: Int)
    
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
            return "/method/video.get"
        }
    }
    
    var parametres: [URLQueryItem] {
        switch self {
        case .fetchVideos(offset: let offset): return [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "owner_id", value: "-58170807"),
            //URLQueryItem(name: "fields", value: "extended"),
            //URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "v", value: Session.shared.v)
        ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchVideos:
            return "GET"
        }
    }
}
