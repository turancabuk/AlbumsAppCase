//
//  AlbumsMainViewModel.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 7.01.2023.
//
import Foundation

final class AlbumsMainViewModel {
    
    var albumsArray: [AlbumElement] = []
    var photosArray: [PhotoElement] = []
    var commentsArray: [CommentElement] = []
    private let webservice: AlbumsWebserviceProtocol
    
    init(webservice: AlbumsWebserviceProtocol) {
        self.webservice = webservice
    }
    
    func fetchAlbums(completion: @escaping (Result<[AlbumElement], Error>) -> Void) {
        webservice.fetch(response: [AlbumElement].self, with: AlbumsAPICall.getAlbum) { result in
            
            switch result {
            case .success(let albums):
                self.albumsArray.append(contentsOf: albums)
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
                print("error")
            }
        }
    }
    func fetchPhotos(completion: @escaping (Result<[PhotoElement], Error>) -> Void) {
        webservice.fetch(response: [PhotoElement].self, with: AlbumsAPICall.getPhotos) { result in
            
            switch result {
            case .success(let photos):
                self.photosArray.append(contentsOf: photos)
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
                print("error")
            }
        }
    }
    func fetchComments(completion: @escaping (Result<[CommentElement], Error>) -> Void) {
        webservice.fetch(response: [CommentElement].self, with: AlbumsAPICall.getComments) { result in
            
            switch result {
            case .success(let comments):
                self.commentsArray.append(contentsOf: comments)
                completion(.success(comments))
            case .failure(let error):
                completion(.failure(error))
                print("error")
            }
        }
    }
}
