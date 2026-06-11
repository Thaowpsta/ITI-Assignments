//
//  Parser.swift
//  Day2
//
//  Created by Thaowpsta Saiid on 09/06/2026.
//

import Foundation

var users: [User] = load(fileName: "users.json")

func load<T: Decodable>(fileName: String) -> T {

    var data: Data

    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else { fatalError("Can't find file") }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Can't get data from file")
    }

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Can't decode data")
    }
}
