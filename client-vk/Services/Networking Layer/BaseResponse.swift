//
//  BaseResponse.swift
//  client-vk
//
//  Created by Mac on 7/25/22.
//

import Foundation

struct BaseResponse<T:Codable>: Codable {
    let response: T
}
