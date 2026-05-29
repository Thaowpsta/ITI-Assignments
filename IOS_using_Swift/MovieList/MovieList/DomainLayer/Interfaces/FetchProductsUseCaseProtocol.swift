//
//  FetchProductsUseCaseProtocol.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//

import Foundation

protocol FetchProductsUseCaseProtocol {
    func fetchRemote(completion: @escaping (Result<[Product], Error>) -> Void)
    func fetchLocal() -> [Product]
}
