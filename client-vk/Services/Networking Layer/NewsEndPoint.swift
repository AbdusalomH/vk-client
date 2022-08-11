//
//  NewsEndPoint.swift
//  client-vk
//
//  Created by Mac on 8/2/22.
//

import Foundation

enum NewsEndPoint: Endpoint {
    
    case fetchNews
    
    
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
        case .fetchNews:
            return [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                    URLQueryItem(name: "access_token", value: Session.shared.accessToken),
                    URLQueryItem(name: "filters", value: "post"),
                    URLQueryItem(name: "start_time", value: "\(2022)"),
                    URLQueryItem(name: "items", value: "note, text, photos, date, source_id"),
                    URLQueryItem(name: "photos", value: "src, src_big"),
                    URLQueryItem(name: "count", value: "20"),
                    URLQueryItem(name: "v", value: Session.shared.v)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .fetchNews:
            return "GET"
        }
    }  
}
