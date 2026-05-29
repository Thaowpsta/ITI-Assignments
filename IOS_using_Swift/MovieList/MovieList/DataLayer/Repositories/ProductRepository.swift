//
//  ProductRepository.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let localDataSource: ProductLocalDataSourceProtocol
    
    init(networkService: NetworkServiceProtocol, localDataSource: ProductLocalDataSourceProtocol) {
            self.networkService = networkService
            self.localDataSource = localDataSource
        }
    
    func getRemoteProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.fetchProducts(completion: completion)
    }
    
    func getLocalProducts() -> [Product] {
        return localDataSource.fetchProducts()
    }
}
