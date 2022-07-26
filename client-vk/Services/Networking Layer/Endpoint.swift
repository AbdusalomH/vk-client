//
//  Endpoint.swift
//  client-vk
//
//  Created by Mac on 7/25/22.
//

import Foundation


protocol Endpoint {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parametres: [URLQueryItem] { get }
    var method: String { get }
 
}
