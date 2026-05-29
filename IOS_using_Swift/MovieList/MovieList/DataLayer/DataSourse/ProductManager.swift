//
//  ProductManager.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 23/05/2026.
//


import Foundation
import UIKit
import CoreData

class ProductManager: ProductLocalDataSourceProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addProduct(_ product: Product) {
        let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)!
        let newProduct = NSManagedObject(entity: entity, insertInto: context)
        
        newProduct.setValue(product.title, forKey: "title")
        newProduct.setValue(product.description, forKey: "desc")
        newProduct.setValue(product.category, forKey: "category")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(product.rating, forKey: "rating")
        
        if let thumbString = product.thumbnail {
            newProduct.setValue(thumbString.data(using: .utf8), forKey: "imageData")
        }
        
        do {
            try context.save()
            print("updated successfully .. ")
        } catch {
            print("Could not insert row: \(error.localizedDescription)")
        }
    }
    
    func fetchProducts() -> [Product] {
        var fetchedProducts: [Product] = []
        let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        
        do {
            let results = try context.fetch(fetchreq)
            
            for p in results {
                let title = p.value(forKey: "title") as? String ?? "Unknown"
                let desc = p.value(forKey: "desc") as? String ?? ""
                let category = p.value(forKey: "category") as? String ?? ""
                let price = p.value(forKey: "price") as? Double ?? 0.0
                let rating = p.value(forKey: "rating") as? Float ?? 0.0
                
                var fetchedThumbnail: String? = nil
                if let data = p.value(forKey: "imageData") as? Data {
                    fetchedThumbnail = String(data: data, encoding: .utf8)
                }
                
                let product = Product(title: title, description: desc, category: category, price: price, rating: rating, thumbnail: fetchedThumbnail)
                fetchedProducts.append(product)
            }
        } catch {
            print("Failed to fetch products: \(error.localizedDescription)")
        }
        
        return fetchedProducts
    }
}
