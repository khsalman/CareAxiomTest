//
//  TwoTestCasesForTest.swift
//  CareAxiomTestApplicationTests
//
//  Created by Khawaja Salman Nadeem on 13/09/2021.
//

import XCTest
@testable import CareAxiomTestApplication

class TwoTestCasesForTest: XCTestCase {

    // Check if picture Data that we feed to uiviewcontroller gets nil
    func testPicDataForNilCase() {
        let picData : [PictureData]? = nil
        XCTAssertNil(picData)
    }
    
    //check if our Iboutlets are properly connected
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
