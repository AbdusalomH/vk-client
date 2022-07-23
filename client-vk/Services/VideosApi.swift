//
//  VideosApi.swift
//  client-vk
//
//  Created by Mac on 7/20/22.
//

import Foundation


class VideosApi {
    
    
    func getVideos(offset: Int = 0, completion: @escaping (Result<[VideosItems], VKError>) -> ()) {
        
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/video.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "owner_id", value: "-58170807"),
            //URLQueryItem(name: "fields", value: "extended"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "v", value: Session.shared.v),
        ]
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if error != nil {
                return
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            print(data.prettyPrintedJSONString)
            
            do {
                let videoos = try decoder.decode(VideosRequest.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(videoos.response.items))
                }

            } catch let err {
                print(err)
            }
        }
        task.resume()
    }
 
}
