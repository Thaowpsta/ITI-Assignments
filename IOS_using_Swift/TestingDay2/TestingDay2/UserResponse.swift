//
//  UserResponse.swift
//  TestingDay2
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//


import Foundation

import Foundation

struct UserResponse: Codable {
    var users: [User]? = []
}

struct User: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError
}


protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class NetworkManager {
    let session: NetworkSession
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.loadData(from: url) { data, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(response.users!))
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
}
