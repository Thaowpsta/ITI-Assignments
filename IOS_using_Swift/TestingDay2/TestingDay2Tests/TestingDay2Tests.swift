//
//  TestingDay2Tests.swift
//  TestingDay2Tests
//
//  Created by Thaowpsta Saiid on 25/05/2026.
//

import XCTest
@testable import TestingDay2

final class TestingDay2Tests: XCTestCase {

    func testFetchDataFromJSON() {
        let myExpectation = expectation(description: "waiting for API ..")

        shouldReturnError = false
        let service = MockNetworkService()

        service.fetchDataFromJSON { result, error in
            if let error = error {
                XCTFail("Unexpected error: \(error)")
            } else {
                XCTAssertEqual(result?.users?.count, 3)
                print("count :: \(String(describing: result?.users?.count)) ---")
                myExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchDataFromJSON_WithError() {
        let myExpectation = expectation(description: "waiting for API failure ..")

        shouldReturnError = true
        let service = MockNetworkService()

        service.fetchDataFromJSON { result, error in
            if let error = error {
                XCTAssertNotNil(error)
                print("Got expected error: \(error)")
                myExpectation.fulfill()
            } else {
                XCTFail("Expected error but got success")
            }
        }

        waitForExpectations(timeout: 1)
    }
}
