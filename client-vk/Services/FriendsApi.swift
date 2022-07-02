//
//  FriendsApi.swift
//  client-vk
//
//  Created by Mac on 7/2/22.
//

import Foundation

// https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131


class FriendsApi {
    
    func fetchFriends(completion: @escaping ([Friend]) -> ()) {
        
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "order", value: "name"),
                                    URLQueryItem(name: "count", value: "5"),
                                    URLQueryItem(name: "fields", value: "bdate, city, photo_100"),
                                    URLQueryItem(name: "v", value:  Session.shared.v),
                                    URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
                                    ]
    
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
//            guard let err = error else {
//                return
//            }
            
            guard let jsonData = data else {return}
            
            print(jsonData.prettyPrintedJSONString)

            
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


