//
//  TableViewUITestsUI.swift
//  TableViewUITestsUI
//
//  Created by TCH Developer on 14/11/2022.
//

import XCTest

class TableViewUITestsUI: XCTestCase {

    func testAddingData() {
        let app = XCUIApplication()
        app.launch()
        
        let newNameInput = app.navigationBars["Work will you"].buttons["Add"]
        
        let nameField = app.alerts["Add Noise Maker"].scrollViews.otherElements.collectionViews.textFields["Shaggy"]
        
        let addBtn = app.alerts["Add Noise Maker"].scrollViews.otherElements.buttons["Add"]
        
        let addedData = app.tables.staticTexts["Joshua"]
        
        newNameInput.tap()
        nameField.tap()
        nameField.typeText("Joshua")
        
        XCTAssertFalse(addedData.exists)
        
        addBtn.tap()
        
        XCTAssertTrue(addedData.exists)
        
    }
    
    func testDeleteProcess() {
        
        let app = XCUIApplication()
        app.launch()
        let newNameInput = app.navigationBars["Work will you"].buttons["Add"]
        
        let nameField = app.alerts["Add Noise Maker"].scrollViews.otherElements.collectionViews.textFields["Shaggy"]
        
        let addBtn = app.alerts["Add Noise Maker"].scrollViews.otherElements.buttons["Add"]
        
        let addedData = app.tables.staticTexts["Victory"]

        let tablesQuery = app.tables
        
        let deleteButton = tablesQuery.buttons["Delete"]

        newNameInput.tap()
        nameField.tap()
        nameField.typeText("Victory")
        addBtn.tap()
        
        addedData.swipeLeft()
        deleteButton.tap()
        XCTAssertFalse(addedData.exists)
    }
    

}
