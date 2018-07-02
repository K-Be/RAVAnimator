//
//  TestLinearValuesConvertor.swift
//  RAVAnimator_Tests
//
//  Created by Andrew Romanov on 02/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import RAVAnimator


class TestLinearValuesConvertor: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testConvertion() {
		let convertor = LinearValuesConvertor()
		convertor.destinationMax = 2.0
		
		XCTAssertEqual(convertor.convertSourceToDestination(source: 0.5), 1.0)
		XCTAssertEqual(convertor.convertDestiantionToSource(destination: 1.0), 0.5)
		
		XCTAssertEqual(convertor.convertSourceToDestination(source: 0.0), 0.0)
		XCTAssertEqual(convertor.convertDestiantionToSource(destination: 0.0), 0.0)
		
		XCTAssertEqual(convertor.convertDestiantionToSource(destination: 2.0), 1.0)
		XCTAssertEqual(convertor.convertSourceToDestination(source: 1.0), 2.0)
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
