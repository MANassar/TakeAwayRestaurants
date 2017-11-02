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
    var jsonFileName:String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        appController = AppController()
        jsonFileName = "sample iOS"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        appController = nil
        jsonFileName = nil
        super.tearDown()
    }
    
    func testJSONPathCanLoad()
    {
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        XCTAssertNotNil(jsonArray, "We couldnt load JSON")
        
    }
    
    func testRestaurantParseFromJSON()
    {
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        let restaurantArray = appController.generateRestaurantArray(fromJSONArray: jsonArray!)
        
        XCTAssertEqual(jsonArray?.count, restaurantArray.count)
    }
    
    func testRestaurantSort()
    {
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        let restaurantArray = appController.generateRestaurantArray(fromJSONArray: jsonArray!)
        let sortCondition:SortOptions = .BestMatch
        
        let sortedRestaurantArray = RestaurantSortController.sortRestaurantSubArray(restaurantsSubArray: restaurantArray, sortOption: sortCondition)
        
    }
    
}
