//
//  ArithmeticTests.swift
//  WeBeTestingSwiftTests
//
//  Created by TCH Developer on 12/11/2022.
//

import XCTest
// Import the project you wish to test.
@testable import WeBeTesting

class ArithmeticTests: XCTestCase {
    
    var initialTest: Arithmetic!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Initialise the test
        initialTest = Arithmetic()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // Once finished set the test case to nil
        initialTest = nil
    }
    
    // Select the play icon to the left of the function to run the tes
    func testPositiveAddition() {
        // Given this input
        let num1 = 2
        let num2 = 7
        
        // When the below happens
        let result = initialTest.add(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, 9)
        
    }
    
    func testNegativeAddition() {
        // Given this input
        let num1 = 2
        let num2 = -7
        
        // When the below happens
        let result = initialTest.add(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, -5)
        
    }
    
    func testWrongAddition() {
        // Given this input
        let num1 = 2
        let num2 = 0
        
        // When the below happens
        let result = initialTest.add(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertNotEqual(result, 20)
        
    }
    
    func testMultiplication() {
        // Given this input
        let num1 = 3
        let num2 = 2
        
        // When the below happens
        let result = initialTest.mul(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, 6)
        
    }
    
    func testMultiplicationSameNum() {
        // Given this input
        let num1 = 2
        let num2 = 2
        
        // When the below happens
        let result = initialTest.mul(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, 4)
        
    }
    
    func testDivision() {
        // Given this input
        let num1 = 2
        let num2 = 2
        
        // When the below happens
        let result = initialTest.div(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, 1)
        
    }
    
    func testSubtraction() {
        // Given this input
        let num1 = 2
        let num2 = 3
        
        // When the below happens
        let result = initialTest.sub(num1: num1, num2: num2)
        
        // Then we want to see whehter the result is equal to 9
        XCTAssertEqual(result, -1)
        
    }

}
