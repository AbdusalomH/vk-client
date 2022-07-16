//
//  GroupPresenter.swift
//  client-vk
//
//  Created by Mac on 7/13/22.
//

import UIKit

protocol GroupPresentProtocol: AnyObject {
    func presentGroup(GroupsResponse: [Group])
    
}

class GroupPresenter {
    
    var delegate: GroupPresentProtocol?
    
    public func getGroups() {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "extended", value: "1"),
                                    URLQueryItem(name: "count", value: "30"),
                                    URLQueryItem(name: "v", value:  Session.shared.v),
                                    URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
                                    ]
        
        
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let groupData = data, error == nil else {return}
            
            do {
                let groups = try JSONDecoder().decode(GroupsJSON.self, from: groupData)
                self.delegate?.presentGroup(GroupsResponse: groups.response.items)
            } catch {
             print(error)
            }
        }
        task.resume()
    }
}
