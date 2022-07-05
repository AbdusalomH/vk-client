//
//  FriendsApi.swift
//  client-vk
//
//  Created by Mac on 7/2/22.
//

import Foundation



class FriendsApi {
    
    func fetchFriends(completion: @escaping ([Friend]) -> ()) {
        
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "order", value: "name"),
                                    URLQueryItem(name: "count", value: "40"),
                                    URLQueryItem(name: "fields", value: "bdate, city, photo_100, country, photo_200_orig"),
                                    URLQueryItem(name: "v", value:  Session.shared.v),
                                    URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
                                    ]
    
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let jsonData = data else {return}
            print(data?.prettyPrintedJSONString)
            
            do {
                let friendsJSON = try JSONDecoder().decode(FriendsJSON.self, from: jsonData)
                let friends = friendsJSON.response.items
                print(Thread.current)
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}


