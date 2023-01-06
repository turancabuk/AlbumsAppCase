//
//  Constant.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import Foundation

enum albumsAPICall: String{
    typealias RawValue = <#type#>
    
    
    private var albumURL: String {
        "https://jsonplaceholder.typicode.com/albums"
    }
    
    private var photosURL: String {
        "https://jsonplaceholder.typicode.com/photos"
    }
    
    private var commentsAPI: String {
        "https://jsonplaceholder.typicode.com/comments"
    }
    
}
