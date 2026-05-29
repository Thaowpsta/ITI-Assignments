//
//  ProductDetailViewModel.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 21/05/2026.
//


import Foundation
import UIKit

class ProductDetailViewModel {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var titleText: String {
        return product.title
    }
    
    var descriptionText: String {
        return product.description
    }
    
    var categoryText: String {
        return "Category: \(product.category)"
    }
    
    var priceText: String {
        return String(format: "Price: $%.2f", product.price) 
    }
    
    var ratingText: String {
        return "Rating: \(product.rating) / 5.0"
    }
    
    var image: String? {
        return product.thumbnail
    }
}
