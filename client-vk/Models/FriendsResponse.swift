//
//  FriendsResponse.swift
//  client-vk
//
//  Created by Mac on 7/2/22.
//

import Foundation

// MARK: - FriendsJSON
struct FriendsJSON: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let bdate: String?
    let city: City?
    let canAccessClosed: Bool?
    let id: Int
    let photo100: String
    let lastName, trackCode: String
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case bdate, city
        case canAccessClosed = "can_access_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

