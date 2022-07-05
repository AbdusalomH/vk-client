//
//  FriendsResponses.swift
//  client-vk
//
//  Created by Mac on 7/4/22.
//

import Foundation

// MARK: - FriendsJSON
struct FriendsJSON: Codable {
    let response: FriendResponse
}

// MARK: - Response
struct FriendResponse: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let bdate: String?
    let canAccessClosed: Bool?
    let id: Int
    let photo200_Orig, photo100: String
    let lastName, trackCode: String
    let isClosed: Bool?
    let firstName: String
    let city, country: City?
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case bdate
        case canAccessClosed = "can_access_closed"
        case id
        case photo100 = "photo_100"
        case photo200_Orig = "photo_200_orig"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case city, country, deactivated
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
