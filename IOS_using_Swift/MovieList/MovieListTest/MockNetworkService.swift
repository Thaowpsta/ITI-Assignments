//
//  MockNetworkService.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//


import Foundation
@testable import MovieList

final class MockNetworkService: NetworkServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[MovieList.Product], any Error>) -> Void) {
        <#code#>
    }
    
    
    var fetchProductsResult: [Product] = []
        
        var isFetchProductsCalled = false
        var isAddProductCalled = false
        var addedProduct: Product?
    

}
