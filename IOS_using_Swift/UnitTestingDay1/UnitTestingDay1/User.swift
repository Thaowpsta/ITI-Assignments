//
//  User.swift
//  UnitTestingDay1
//
//  Created by Thaowpsta Saiid on 24/05/2026.
//


struct User {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func authenticate() -> Bool {
        if username.count > 5 && password.count >= 10 {
            return true
        } else {
            return false
        }
    }
}