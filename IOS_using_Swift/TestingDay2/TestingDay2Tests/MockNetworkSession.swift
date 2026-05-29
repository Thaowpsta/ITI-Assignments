//
//  MockNetworkSession 2.swift
//  TestingDay2
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//


//
//  MockNetworkSession.swift
//  TestingDay2
//

import XCTest
@testable import TestingDay2

let fakeJSONObj: [String: Any] = [
    "users": [
        ["id": 1, "firstName": "Thaowpsta", "lastName": "Saiid"],
        ["id": 2, "firstName": "Nardeen",   "lastName": "Saiid"],
        ["id": 3, "firstName": "Fady",      "lastName": "Mesiha"]
    ]
]

var shouldReturnError = false

class MockNetworkService {
    func fetchDataFromJSON(complitionHandler: @escaping (UserResponse?, Error?) -> Void) {
        var result: UserResponse?

        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
            result = try JSONDecoder().decode(UserResponse.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }

        if shouldReturnError {
            complitionHandler(nil, NSError(domain: "NetworkError", code: 404, userInfo: nil))
        } else {
            complitionHandler(result, nil)
        }
    }
}
