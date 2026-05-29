//
//  UnitTestingDay1Tests.swift
//  UnitTestingDay1Tests
//
//  Created by Thaowpsta Saiid on 24/05/2026.
//

import XCTest
@testable import UnitTestingDay1

final class UserTest: XCTestCase {

    var user: User!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User(username: "defaultUser", password: "defaultPassword12")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user = nil
    }

    func testUser_Initialization_IsNotNil() {
            XCTAssertNotNil(user, "The User object should not be nil after initialization.")
        }

        func testUser_AuthenticateWithValidCredentials_ReturnsTrue() {

            user.username = "ValidName"
            user.password = "ValidPassword123"
            
            let result = user.authenticate()
            
            XCTAssertTrue(result, "Authentication should return true for valid credentials.")
        }

        func testUser_AuthenticateWithShortUsername_ReturnsFalse() {

            user.username = "user"
            user.password = "ValidPassword123"
            
            let result = user.authenticate()
            
            XCTAssertFalse(result, "Authentication should return false if the username is 5 characters or less.")
        }

        func testUser_UsernameAssignment_IsEqual() {

            let expectedUsername = "TestUser"
            user.username = expectedUsername
            
            XCTAssertEqual(user.username, expectedUsername, "The username should match the assigned value.")
        }
        
        func testUser_NilSimulation_Fails() {

            let optionalUser: User? = nil
            
            if optionalUser == nil {
                XCTFail("FAILED.")
            }
        }

}
