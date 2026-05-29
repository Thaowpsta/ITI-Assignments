//
//  MockNetworkService 2.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//


import Foundation
@testable import MovieList

final class MockProductLocalDataSource: ProductLocalDataSourceProtocol {
    
    var fetchProductsResult: [Product] = []
        
        var isFetchProductsCalled = false
        var isAddProductCalled = false
        var addedProduct: Product?
        
        func addProduct(_ product: Product) {
            isAddProductCalled = true
            addedProduct = product
        }
        
        func fetchProducts() -> [Product] {
            isFetchProductsCalled = true
            return fetchProductsResult
        }
}
