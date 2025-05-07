//
//  PersonalBudgetManagerUITests.swift
//  PersonalBudgetManagerUITests
//
//  Created by user271744 on 4/22/25.
//

import XCTest

final class PersonalBudgetManagerUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testInitialScreen() throws {
        //Given
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["Go Inside..."]/*[[".otherElements.buttons[\"Go Inside...\"]",".buttons.firstMatch",".buttons[\"Go Inside...\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Sign Up"]/*[[".otherElements.buttons[\"Sign Up\"]",".buttons[\"Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Sign In"]/*[[".otherElements.buttons[\"Sign In\"]",".buttons[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //When
        app/*@START_MENU_TOKEN@*/.textFields["your@email.com"]/*[[".otherElements.textFields[\"your@email.com\"]",".textFields.firstMatch",".textFields[\"your@email.com\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let secureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["********"]/*[[".otherElements.secureTextFields[\"********\"]",".secureTextFields.firstMatch",".secureTextFields[\"********\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        secureTextField.tap()
        secureTextField.tap()
        
        //Then
        app.buttons.matching(identifier: "Sign In").element(boundBy: 1).tap()
        
    }
}


