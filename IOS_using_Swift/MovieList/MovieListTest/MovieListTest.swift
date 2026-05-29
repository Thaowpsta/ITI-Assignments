//
//  MovieListTest.swift
//  MovieListTest
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//

import XCTest
@testable import MovieList

final class ProductRepositoryTests: XCTestCase {

    var repository: ProductRepository!
    var mockNetworkService: MockNetworkService!
    var mockLocalDataSource: MockProductLocalDataSource! 

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        mockLocalDataSource = MockProductLocalDataSource()
        repository = ProductRepository(networkService: mockNetworkService, localDataSource: mockLocalDataSource)
    }

    override func tearDown() {
        repository = nil
        mockNetworkService = nil
        mockLocalDataSource = nil
        super.tearDown()
    }

    func testGetRemoteProducts_Success() {
        let expectedProducts = [
            Product(title: "The Matrix", description: "Sci-Fi", category: "Movies", price: 9.99, rating: 8.7, thumbnail: nil)
        ]
        
        mockNetworkService.fetchProductsResult = .success(expectedProducts)
        
        let expectation = XCTestExpectation(description: "Fetch products from remote")
        
        repository.getRemoteProducts { result in

            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "The Matrix")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockNetworkService.fetchProductsCalled, "The network service should have been called")
    }
}
