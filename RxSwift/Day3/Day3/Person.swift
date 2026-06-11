//
//  Person.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 02/06/2026.
//


struct Person {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}