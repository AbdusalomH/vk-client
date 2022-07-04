//
//  GroupsApi.swift
//  client-vk
//
//  Created by Mac on 7/4/22.
//

import Foundation


class GroupsApi {
    
    func fetchGroups(completion: @escaping ([Group]) -> ()) {

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
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, err in
            
            
            if err != nil {
                return
            }
            
            if let groupResponse = data {
                do {
                    let groupsJSON = try JSONDecoder().decode(GroupsJSON.self, from: groupResponse)
                    let receivedGroup = groupsJSON.response.items
                    DispatchQueue.main.async {
                        completion(receivedGroup)
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()

    }
}
