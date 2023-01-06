//
//  Constant.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import Foundation

enum albumsAPICall: String{
    
    
    private var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    private var albumURL: String {
        "/albums"
    }
    
    private var photosURL: String {
        "/photos"
    }
    
    private var commentsURL: String {
        "/comments"
    }
    
    case getAlbum
    case getPhotos
    case getComments
    
    var urlString: String {
        switch self {
        case .getAlbum:
            return "\(baseURL)\(albumURL)"
        case .getPhotos:
            return "\(baseURL)\(photosURL)"
        case .getComments:
            return "\(baseURL)\(commentsURL)"
        }
    }
    
    var url: URL {
        return URL(string: urlString)!
    }
}
