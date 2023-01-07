//
//  Webservice.swift
//  AlbumsApp
//
//  Created by Turan Çabuk on 6.01.2023.
//

import Foundation


protocol AlbumsWebserviceProtocol {
    func fetch<T: Decodable>(response: T.Type, with path: AlbumsAPICall, completion: @escaping(Result<T, Error>) -> Void)
}
final class AlbumsWebservice: AlbumsWebserviceProtocol {
    func fetch<T>(response: T.Type, with path: AlbumsAPICall, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
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



































//func fetchData<T: Decodable>(from apiCall: AlbumsAPICall, with completion: @escaping (Result<T, Error>) -> Void) {
//    let task = URLSession.shared.dataTask(with: apiCall.url) { data, response, error in
//        if let error = error {
//            completion(.failure(error))
//            return
//        }
//
//        guard let data = data else {
//            let error = NSError(domain: "com.example.AlbumsApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data is nil"])
//            completion(.failure(error))
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(T.self, from: data)
//            completion(.success(decodedData))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    task.resume()
//}
