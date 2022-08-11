// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailsRep = try? newJSONDecoder().decode(DetailsRep.self, from: jsonData)

import Foundation

// MARK: - DetailsRep
struct DetailsRep: Codable {
    let response: DetailsResponse
}

// MARK: - Response
struct DetailsResponse: Codable {
    let items: [ResponseItem]

    let groups: [ResponseGroup]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct ResponseGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - ResponseItem
struct ResponseItem: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory, isFavorite: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: ResponseComments?
    let likes: PurpleLikes?
    let reposts: ResponseReposts?
    let views: ResponseViews?
    let donut: ResponseDonut?
    let shortTextRate: Double?
    let postID: Int?
    let type: String?
    let photos: Photos?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views, donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type, photos
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let photo: ReponsePhoto?
    let video: ResponseVideo?
}

// MARK: - Photo
struct ReponsePhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let accessKey: String?
    let postID: Int?
    let sizes: [ResponseSize]?
    let text: String?
    let userID: Int?
    let hasTags: Bool?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
}

// MARK: - Size
struct ResponseSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width, withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Video
struct ResponseVideo: Codable {
    let accessKey: String?
    let canComment, canLike, canRepost, canSubscribe: Int?
    let canAddToFaves, canAdd, comments, date: Int?
    let videoDescription: String?
    let duration: Int?
    let image, firstFrame: [ResponseSize]?
    let width, height, id, ownerID: Int?
    let title: String?
    let isFavorite: Bool?
    let trackCode, type: String?
    let views: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
    }
}

// MARK: - Comments
struct ResponseComments: Codable {
    let canPost, count: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct ResponseDonut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let canLike, count, userLikes, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let items: [PhotosItem]?
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let albumID, date, id, ownerID: Int?
    let accessKey: String?
    let canComment, postID: Int?
    let sizes: [Size]?
    let text: String?
    let userID: Int?
    let hasTags: Bool?
    let likes: FluffyLikes?
    let comments: Views?
    let reposts: Reposts?
    let canRepost: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case canComment = "can_comment"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case likes, comments, reposts
        case canRepost = "can_repost"
    }
}

// MARK: - Views
struct ResponseViews: Codable {
    let count: Int?
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct ResponseReposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String?
}



