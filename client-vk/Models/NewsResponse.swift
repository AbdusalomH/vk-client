// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsJSON = try? newJSONDecoder().decode(NewsJSON.self, from: jsonData)

import Foundation

// MARK: - NewsJSON
struct NewsJSON: Codable {
    let response: NewsResponse?
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [NewsPost]?
    let groups: [NewsGroup]?
    let profiles: [NewsProfile]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let isMember, id: Int?
    let photo100: String?
    let isAdvertiser, isAdmin: Int?
    let photo50, photo200: String?
    let type: String?
    let screenName, name: String?
    let isClosed: Int?

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}


// MARK: - Item
struct NewsPost: Codable {
    let donut: Donut?
    let isFavorite, canSetCategory: Bool?
    let comments: Comments?
    let shortTextRate: Double?
    let likes: Likes?
    let reposts: Reposts?
    let type, postType: String?
    let carouselOffset, date: Int?
    let sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [ItemAttachment]?
    let markedAsAds, postID: Int?
    let postSource: ItemPostSource?
    let views: Views?
    let topicID: Int?
    let copyHistory: [CopyHistory]?

    enum CodingKeys: String, CodingKey {
        case donut
        case isFavorite = "is_favorite"
        case canSetCategory = "can_set_category"
        case comments
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case carouselOffset = "carousel_offset"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views
        case topicID = "topic_id"
        case copyHistory = "copy_history"
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: String?
    let photo: Photo?
    let link: Link?
    let video: Video?
}

// MARK: - Link
struct Link: Codable {
    let isFavorite: Bool?
    let title: String?
    let url: String?
    let linkDescription, target: String?

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, url
        case linkDescription = "description"
        case target
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, id, date: Int?
    let text: String?
    let userID: Int?
    let sizes: [Size]?
    let hasTags: Bool?
    let ownerID: Int?
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int?
    let url: String?
    let type: String?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case width, height, url, type
        case withPadding = "with_padding"
    }
}


// MARK: - Video
struct Video: Codable {
    let ownerID: Int?
    let title: String?
    let canAdd, duration: Int?
    let image: [Size]?
    let isFavorite: Bool?
    let views: Int?
    let type: String?
    let canLike, canComment: Int?
    let firstFrame: [Size]?
    let date, id, height: Int?
    let trackCode: String?
    let width, canAddToFaves: Int?
    let accessKey: String?
    let comments, canSubscribe, canRepost: Int?
    let videoDescription: String?

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image
        case isFavorite = "is_favorite"
        case views, type
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame = "first_frame"
        case date, id, height
        case trackCode = "track_code"
        case width
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case videoDescription = "description"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let postSource: CopyHistoryPostSource?
    let postType: String?
    let id, fromID, date: Int?
    let text: String?
    let attachments: [CopyHistoryAttachment]?
    let ownerID: Int?

    enum CodingKeys: String, CodingKey {
        case postSource = "post_source"
        case postType = "post_type"
        case id
        case fromID = "from_id"
        case date, text, attachments
        case ownerID = "owner_id"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: String?
    let photo: Photo?
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    let type: String?
}



// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    let type: String?
    let platform: String?
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}

// MARK: - Profile
struct NewsProfile: Codable {
    let online: Int?
    let canAccessClosed, isClosed: Bool?
    let id: Int?
    let photo100: String?
    let lastName: String?
    let photo50: String?
    let onlineInfo: OnlineInfo?
    let sex: Int?
    let screenName, firstName: String?

    enum CodingKeys: String, CodingKey {
        case online
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let isMobile: Bool?
    let lastSeen: Int?
    let isOnline, visible: Bool?

    enum CodingKeys: String, CodingKey {
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case visible
    }
}

