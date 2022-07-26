//
//  Sessions.swift
//  client-vk
//
//  Created by Mac on 7/25/22.
//

import Foundation

class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var accessToken: String = ""
    var userid: Int = 0
    var expiresIn: Int = 0
    var v: String = "5.131"

}
