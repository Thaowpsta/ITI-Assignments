//
//  ProductRepositoryProtocol.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getRemoteProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func getLocalProducts() -> [Product]
}
