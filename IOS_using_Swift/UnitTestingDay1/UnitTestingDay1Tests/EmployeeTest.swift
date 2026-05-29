//
//  EmployeeTest.swift
//  UnitTestingDay1
//
//  Created by Thaowpsta Saiid on 24/05/2026.
//

import XCTest
@testable import UnitTestingDay1
 
final class EmployeeTest: XCTestCase {
 
    var emp: Employee?
 
    override func setUpWithError() throws {
        try super.setUpWithError()
        emp = Employee(name: "Ahmed")
    }
 
    override func tearDownWithError() throws {
//        emp = nil
        try super.tearDownWithError()
    }
 
    func testEmployee_GrossSalaryIsNil_XCTFail() {
        guard let emp = emp else {
            XCTFail("Employee was not initialized.")
            return
        }
 
        if emp.grossSalary == nil {
            XCTFail("Gross salary is nil. It must be set before calculating net salary.")
        }
    }
 

    func testEmployee_Initialization_IsNotNil() {
        XCTAssertNotNil(emp, "Employee should not be nil after initialization.")
    }
 

    func testEmployee_AnnualSalary_IsGreaterThanMinimum() {
        guard let emp = emp else {
            XCTFail("Employee was not initialized.")
            return
        }
 
        // Given
        emp.grossSalary = 6000.0  // 6000 - 5% = 5700 * 12 = 68,400
 
        // When
        emp.calcNetSalary()
 
        // Then
        XCTAssertTrue(
            emp.annualNetSalary > emp.minAnnualNetSalary,
            "Annual salary \(emp.annualNetSalary) should be greater than minimum \(emp.minAnnualNetSalary)."
        )
    }
 

    func testEmployee_AnnualSalary_IsLessThanMaximum() {
        guard let emp = emp else {
            XCTFail("Employee was not initialized.")
            return
        }
 
        // Given
        emp.grossSalary = 6000.0  // 6000 - 5% = 5700 * 12 = 68,400
 
        // When
        emp.calcNetSalary()
 
        // Then
        XCTAssertFalse(
            emp.annualNetSalary > emp.maxAnnualNetSalary,
            "Annual salary \(emp.annualNetSalary) should NOT exceed maximum \(emp.maxAnnualNetSalary)."
        )
    }

    func testEmployee_DeductionPercentage_For5000_IsEqual5() {
        guard let emp = emp else {
            XCTFail("Employee was not initialized.")
            return
        }
 
        // Given
        emp.grossSalary = 5000.0
 
        // When
        emp.calcNetSalary()
 
        // Then
        XCTAssertEqual(
            emp.deductionsPersentage,
            5.0,
            "Deduction percentage should be exactly 5.0 for a gross salary of 5,000."
        )
    }
}
 
