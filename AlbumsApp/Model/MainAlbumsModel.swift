//
//  MainAlbumsModel.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import Foundation

// MARK: - UniqueElement
struct UniqueElement: Codable {
    let album: AlbumElement
    let comment: CommentElement
    let photo: PhotoElement
    var photos: [PhotoElement]
}

// MARK: - AlbumElement
struct AlbumElement: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
// MARK: - PhotoElement
struct PhotoElement: Codable {
    let albumID, id: Int?
    let title: String
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
// MARK: - CommentElement
struct CommentElement: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}


