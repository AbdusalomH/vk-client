//
//  VideosResponse.swift
//  client-vk
//
//  Created by Mac on 7/20/22.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videosResponse = try? newJSONDecoder().decode(VideosResponse.self, from: jsonData)


// MARK: - VideosResponse
struct VideosRequest: Codable {
    let response: VideosResponse
}

// MARK: - Response
struct VideosResponse: Codable {
    let count: Int
    let items: [VideosItems]
}

// MARK: - Item
struct VideosItems: Codable {
    let ownerID: Int?
    let title: String?
    let canAdd, duration: Int?
    let image: [FirstFrame]
    let likes: VideosLikes?
    let ovID: String?
    let isFavorite: Bool?
    let addingDate, views: Int?
    let itemRepeat: Int?
    let added: Int?
    let type: String?
    let canLike, canComment: Int?
    let firstFrame: [FirstFrame]?
    let date, id: Int?
    let player: String?
    let reposts: VideoosReposts?
    let height, width: Int?
    let canAddToFaves, comments, canSubscribe, canRepost: Int?
    let itemDescription: String?
    let platform: String?
    let localViews: Int?

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image, likes
        case ovID = "ov_id"
        case isFavorite = "is_favorite"
        case addingDate = "adding_date"
        case views
        case itemRepeat = "repeat"
        case added, type
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame = "first_frame"
        case date, id, player, reposts, height, width
        case canAddToFaves = "can_add_to_faves"
        case comments
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case itemDescription = "description"
        case platform
        case localViews = "local_views"
    }
}

// MARK: - FirstFrame
struct FirstFrame: Codable {
    let url: String?
    let width, height: Int?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case url, width, height
        case withPadding = "with_padding"
    }
}

// MARK: - Likes
struct VideosLikes: Codable {
    let count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct VideoosReposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

