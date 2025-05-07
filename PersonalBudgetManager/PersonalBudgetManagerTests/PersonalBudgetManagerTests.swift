//
//  PersonalBudgetManagerTests.swift
//  PersonalBudgetManagerTests
//
//  Created by user271744 on 4/22/25.
//

import XCTest
@testable import PersonalBudgetManager

final class PersonalBudgetManagerTests: XCTestCase {

    func testTotalExpenses() {
        //Given
        let expense1: Double = 1000
        let expense2: Double = 2000
        
        //When
        let result = expense1 + expense2
        
        //Then
        XCTAssertEqual(result, 3000, "Calculation of total expenses failed")
    }
    
    func testTotalIncome() {
        //Given
        let income1: Double = 2000
        let income2: Double = 2000
        
        //When
        let result = income1 + income2
        
        //Then
        XCTAssertEqual(result, 4000, "Calculation of total income failed")
    }
    
    func testTotalRemaining() {
        //Given
        let assets: Double = 5000
        let income: Double = 1000
        let expense: Double = 2000
        
        //When
        let result = (assets + income) - expense
        
        //Then
        XCTAssertEqual(result, 4000, "Calculation of remaining amount failed")
    }}
