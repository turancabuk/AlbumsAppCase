//
//  Webservice.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import Foundation


protocol AlbumsWebserviceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: AlbumsAPICall, completion: @escaping(Result<T, Error>) -> Void)
}
final class AlbumsWebservice: AlbumsWebserviceProtocol {
    func fetch<T>(response: T.Type, with path: AlbumsAPICall, completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        let urlRequest = URLRequest(url: path.url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
enum NetworkError: Error {
    case dataNotFound
}


































