//
//  FriendsApi.swift
//  client-vk
//
//  Created by Mac on 7/2/22.
//

import Foundation



class FriendsApi {
    
    func fetchFriends(offset: Int = 0, completion: @escaping (Result<[Friend], VKError>) -> ()) {
        
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "order", value: "name"),
                                    URLQueryItem(name: "count", value: "20"),
                                    URLQueryItem(name: "offset", value: "\(offset)"),
                                    URLQueryItem(name: "fields", value: "bdate, city, photo_100, country, photo_200_orig"),
                                    URLQueryItem(name: "v", value:  Session.shared.v),
                                    URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)")
                                    ]
    
        guard let url = urlComponents.url else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.DataError))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(.DataError))
                return
                
            }
            
            do {
                let friendsJSON = try JSONDecoder().decode(FriendsJSON.self, from: jsonData)
                let friends = friendsJSON.response.items
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}


