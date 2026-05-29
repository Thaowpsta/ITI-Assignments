//
//  NetworkService.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 21/05/2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
//                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//                let dict = jsonData?["products"] as? [[String: Any]] ?? []
//                
//                var fetchedApiProducts: [Product] = []
//                
//                for productData in dict {
//                    let newProduct = Product(
//                        title: productData["title"] as? String ?? "Unknown",
//                        description: productData["description"] as? String ?? "",
//                        category: productData["category"] as? String ?? "",
//                        price: productData["price"] as? Double ?? 0.0,
//                        rating: Float(productData["rating"] as? Double ?? 0.0),
//                        image: productData["thumbnail"] as? String
//                    )
//                    fetchedApiProducts.append(newProduct)
//                }
                
                let decoder = JSONDecoder()
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                
                completion(.success(productResponse.products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
