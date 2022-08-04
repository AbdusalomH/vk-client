//
//  NewsApi.swift
//  client-vk
//
//  Created by Mac on 7/11/22.
//

import Foundation


class NewsApi {
    
    
    
    func getNews(completion: @escaping (Result<[PostCellModel], VKError>) -> ()){
        
        var urlComponenst = URLComponents()
        
        urlComponenst.scheme = "https"
        urlComponenst.host = "api.vk.com"
        urlComponenst.path = "/method/newsfeed.get"
        
        urlComponenst.queryItems = [URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
                                    URLQueryItem(name: "access_token", value: Session.shared.accessToken),
                                    URLQueryItem(name: "filters", value: "post"),
                                    URLQueryItem(name: "start_time", value: "\(2022)"),
                                    URLQueryItem(name: "items", value: "note, text, photos, date, source_id"),
                                    URLQueryItem(name: "photos", value: "src, src_big"),
                                    URLQueryItem(name: "count", value: "20"),
                                    URLQueryItem(name: "v", value: Session.shared.v),]
        
        guard let url = urlComponenst.url else {return}
        
        print(url)
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, err in

            if err != nil {
                return
            }
            
            guard let newsData = data else {return}
            
            print(newsData.prettyPrintedJSONString)
            
          let decoder = JSONDecoder()

            do {
                
              let newsResponse = try decoder.decode(NewsJSON.self, from: newsData)
              let newsItems = newsResponse.response?.items ?? []
              let newsGroups = newsResponse.response?.groups ?? []
              let newsProfile = newsResponse.response?.profiles ?? []
                                                    
              var cellModels: [PostCellModel] = []
                
   
                for post in newsItems {
                    
                    let sourceID = post.sourceID
                    
                    var authorName = ""
                    var authorImageURL = ""
                    let postText = post.text ?? ""
                    let postImage = post.attachments?.first?.photo?.sizes?.last?.url ?? ""
                    let lowPostQualityImage = post.attachments?.first?.photo?.sizes?[2].url ?? ""
                    let postLike = post.likes?.count ?? 0
                    
                    if sourceID < 0 {
                        
                        let group = newsGroups.first(where: {$0.id == abs(sourceID)})
                                       
                        authorName = group?.name ?? ""
                        authorImageURL = group?.photo100 ?? ""
                    
                  
                    } else {
                        
                        let profile = newsProfile.first(where: {$0.id == abs(sourceID)})
                        
                        authorName = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
                        authorImageURL = profile?.photo100 ?? ""
                    }
                    
                    
                    let cellModel = PostCellModel(authorName: authorName, authorImageURL: authorImageURL, text: postText, imageURL: lowPostQualityImage, likesCount: postLike)
                    
                    cellModels.append(cellModel)
                    
                }

                completion(.success(cellModels))
            
         } catch let errors {
             print(errors)
         }
    }
        task.resume()
    }

}
