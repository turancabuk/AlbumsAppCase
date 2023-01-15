//
//  AlbumsMainViewModel.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 7.01.2023.
//
import Foundation

final class AlbumsMainViewModel {
    
   
    
    var uniqueElement: [UniqueElement] = []
    
    var albums: [AlbumElement] = []
    var comments: [CommentElement] = []
    var photos: [PhotoElement] = []
    var albumList: [UniqueElement] = []

    
    private let webservice: AlbumsWebserviceProtocol
    
    init(webservice: AlbumsWebserviceProtocol) {
        self.webservice = webservice
    }
    
    func getPhotos(albumId: Int) -> [PhotoElement] {
            return self.photos.filter { $0.albumID == albumId }
        }
    
    
    func fetchData(completion: @escaping (Result<[UniqueElement], Error>) -> Void) {
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            webservice.fetch(response: [AlbumElement].self, with: .getAlbum) { result in
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
            webservice.fetch(response: [CommentElement].self, with: .getComments) { result in
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
            webservice.fetch(response: [PhotoElement].self, with: .getPhotos) { result in
                switch result {
                case .success(let fetchedPhotos):
                    self.photos = fetchedPhotos
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }

            // Adding this line of code
            dispatchGroup.notify(queue: .main) {
                for album in self.albums {
                    let albumId = album.id
                    let relevantComments = self.comments.filter { $0.postID == albumId }
                    let relevantPhotos = self.photos.filter { $0.albumID == albumId }
                    for comment in relevantComments {
                        for photo in relevantPhotos {
                            self.albumList.append(UniqueElement(album: album, comment: comment, photo: photo, photos: self.photos))
                        }
                    }
                }
                completion(.success(self.albumList))
            }
        }
    
}
