//
//  ProductLocalDataSourceProtocol.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//


protocol ProductLocalDataSourceProtocol {
    func addProduct(_ product: Product)
    func fetchProducts() -> [Product]
}