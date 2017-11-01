//
//  TakeAwayRestaurantsTests.swift
//  TakeAwayRestaurantsTests
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import XCTest
@testable import TakeAwayRestaurants

class TakeAwayRestaurantsTests: XCTestCase {
    
    var appController:AppController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        appController = AppController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONPathCanLoad() {
        //Assumption
//        let testExpectation = expectation(description: "Loaded JSON Successfully")
        
        XCTAssertTrue(appController.loadJSONFile(), "We couldnt load JSON")
        
    }
    
    func testRestaurantParseFromJSON()
    {
        
    }
    
    func testRestaurantSort()
    {
        
    }
    
}
