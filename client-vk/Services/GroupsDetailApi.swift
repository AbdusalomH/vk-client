//
//  GroupsDetailApi.swift
//  client-vk
//
//  Created by Mac on 8/4/22.
//

import Foundation

class GroupDetailsApi {
    
    func fetchGroupDetail(groupDetailsID: Int, competion: @escaping (Result<[ResponseItem], Error>)-> ()) {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.vk.com"
        urlComponent.path = "/method/newsfeed.get"
        urlComponent.queryItems = [
                                    URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "access_token", value: "\(Session.shared.accessToken)"),
                                    URLQueryItem(name: "source_ids", value: "\(groupDetailsID)"),
                                    URLQueryItem(name: "count", value: "20"),
                                    URLQueryItem(name: "v", value:  Session.shared.v),
                                    ]
        
        guard let url = urlComponent.url else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, _, err in
            
            if err != nil {
                return
            }
            
            guard let groupDetails = data else {return}
            let decode = JSONDecoder()
            
            do {
                
                let detailsResponse = try decode.decode(DetailsRep.self, from: groupDetails)
                let responseItems = detailsResponse.response.items
                
                DispatchQueue.main.async {
                    competion(.success(responseItems))
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    } 
}
