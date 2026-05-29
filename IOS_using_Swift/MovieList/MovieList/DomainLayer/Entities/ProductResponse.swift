//
//  ProductResponse.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//


struct ProductResponse: Codable {
    var products: [Product]
    var total: Int?
    var skip: Int?
    var limit: Int?
}