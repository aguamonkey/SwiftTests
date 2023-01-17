//
//  UnitTestingBootcampViewMondel_Tests.swift
//  Protocols+Dependency+TestingTests
//
//  Created by Gobias LTD on 17/01/2023.
//

import XCTest
@testable import Protocols_Dependency_Testing
import Combine

// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Then

// Use Command Shift K for clearing tests


final class UnitTestingBootcampViewMondel_Tests: XCTestCase {
    
    
    var viewModel: UnitTestingBootcampViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
        
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
        
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
        
    }
    
    // This test is safer than the above because we run enought tests to cover all of the cases.
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
        
    }
    
    func test_UniteTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        
    }
    
    func test_UniteTestingBootcampViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        // Would be better to create a function to create a random string but UUID will do for now
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        // then
        
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
    }
    
    func test_UniteTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        // then
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UniteTestingBootcampViewModel_dataArray_shouldNotAddBlankString2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "")
        // then
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UniteTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // then
        
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UniteTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        // Select Valid Item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // select invalid item
        vm.selectItem(item: UUID().uuidString)
        // then
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UniteTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    // The below is a much more sophisticated test thatn the one above
    func test_UniteTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        XCTAssertFalse(randomItem.isEmpty)

        
        // then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UniteTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should Throw Item Not Found Error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }

    }
    
    func test_UniteTestingBootcampViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }

    }
    
    func test_UniteTestingBootcampViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch  {
            XCTFail()
        }
                         
    }
    
    func test_UniteTestingBootcampViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let expectation = XCTestExpectation(description: "Should return items after three seconds")
        // you need to have a good understanding of when these stored values are published
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
                         
    }
    
    func test_UniteTestingBootcampViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        // you need to have a good understanding of when these stored values are published
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
                         
    }
    
    
}
