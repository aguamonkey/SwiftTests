//
//  ConverterUnitTests.swift
//  ConverterUnitTests
//
//  Created by TCH Developer on 18/11/2022.
//

import XCTest

class ConverterUnitTests: XCTestCase {
    
    private var sut: Converters!

    override func setUpWithError() throws {
        // sut is system under testing
        // We are arranging here to prevent duplications of variable creations in the process
        sut = Converters()
    }
    
    override func tearDownWithError() throws {
        // We set to nil here once the test has completed
        sut = nil
    }
    
    // Simple conversion with a postive number
    func test_convert10_returns1080() {
        let actual = sut.convertEuroToUSD(euro: "10")
        let expected = "$10.80"
        
        XCTAssertEqual(actual, expected)
    }
    
    // Negative number returns an error message
    func test_convertNeg10_returnError() {
        // Arrange
        
        // Act
        let actual = sut.convertEuroToUSD(euro: "-10")
        let expected = "Please enter a positive number"
        
        // Assert
        XCTAssertEqual(actual, expected)
    }

    func test_convertEmptyString() {
        let actual = sut.convertEuroToUSD(euro: "")
        let expected = "Please enter a positive number"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_invailidInput() {
        let actual = sut.convertEuroToUSD(euro: "How much do I have?")
        let expected = "Please enter a positive number"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_convertDecimal() {
        let actual = sut.convertEuroToUSD(euro: "10.50")
        let expected = "$11.34"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_Million() {
        let actual = sut.convertEuroToUSD(euro: "10000000")
        let expected = "Value too large to convert"
        
        XCTAssertEqual(actual, expected)
    }
    
}


