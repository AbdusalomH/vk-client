//
//  API.swift
//  client-vk
//
//  Created by Mac on 7/25/22.
//

import Foundation

//Сервис универсального запроса
class Api {
    
    //Через колбэки
    class func request<T: Codable>(endpoint: Endpoint, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        
        //1. Конструируем URL
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parametres
        
        guard let url = urlComponents.url else { return }
        
        //2. Конструируем HTTP-запрос
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        
        //3. Отправляем запрос
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                return
            }
            
            
            guard let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode == 200 else {
                return completion(.failure(VKError.ResponseErroor))
                
            }
            
            guard let data = data else {
                return completion(.failure(VKError.DataError))
            }
            
            do {
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
                let responseObject = response.response
                
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }
        dataTask.resume()
    
    }
 
}
