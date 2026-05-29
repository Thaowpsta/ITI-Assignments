//
//  FetchProductsUseCase.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//

import Foundation

class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchRemote(completion: @escaping (Result<[Product], Error>) -> Void) {
        repository.getRemoteProducts(completion: completion)
    }
    
    func fetchLocal() -> [Product] {
        return repository.getLocalProducts()
    }
}
