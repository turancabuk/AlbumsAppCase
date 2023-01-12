//
//  AlbumsMainViewModel.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 7.01.2023.
//
import Foundation

final class AlbumsMainViewModel {
    
    private let webservice: AlbumsWebserviceProtocol
    
    var uniqueElement: [UniqueElement] = []
    
    var albums: [AlbumElement] = []
    var comments: [CommentElement] = []
    var photos: [PhotoElement] = []
    
    init(webservice: AlbumsWebserviceProtocol) {
        self.webservice = webservice
    }

    
    
    func fetchData(completion: @escaping (Result<[UniqueElement], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        webservice.fetch(response: [AlbumElement].self, with: AlbumsAPICall.getAlbum) { result in
            switch result {
            case .success(let fetchedAlbums):
                self.albums = fetchedAlbums
                dispatchGroup.leave()
            case .failure(let error):
                completion(.failure(error))
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        webservice.fetch(response: [CommentElement].self, with: AlbumsAPICall.getComments) { result in
            switch result {
            case .success(let fetchedComments):
                self.comments = fetchedComments
                dispatchGroup.leave()
            case .failure(let error):
                completion(.failure(error))
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        webservice.fetch(response: [PhotoElement].self, with: AlbumsAPICall.getPhotos) { result in
            switch result {
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
                dispatchGroup.leave()
            case .failure(let error):
                completion(.failure(error))
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            for album in self.albums {
                let albumId = album.id
                let relevantComments = self.comments.filter { $0.postID == albumId }
                let relevantPhotos = self.photos.filter { $0.albumID == albumId }
                for comment in relevantComments {
                    for photo in relevantPhotos {
                        self.uniqueElement.append(UniqueElement(album: album, comment: comment, photo: photo))
                    }
                }
            }
            completion(.success(self.uniqueElement))
        }
    }
}
