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
    
    
    //This function checks that we actually have restaurants and whether the restaruant array count matches the JSON array count
    func testRestaurantCountMatchesJSONCount()
    {
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = appController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        XCTAssertEqual(jsonArray?.count, restaurantArray.count)
    }
    
    func testRestaurantSort()
    {
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = appController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        let sortCondition:SortOptions = .BestMatch
        
        let sortedRestaurantArray = RestaurantSortController.sortRestaurantSubArray(restaurantsSubArray: restaurantArray, sortOption: sortCondition)
        
        //Now we will check that the sorted array is really sorted.. We will take a value in the middle, and confirm all those after it are lower and all before it are higher.
        let indexOfSampleRestaurant = sortedRestaurantArray.count/2
        let sampleRestaurant = sortedRestaurantArray[indexOfSampleRestaurant]
        
        for var i in 0..<sortedRestaurantArray.count
        {
            if (i == indexOfSampleRestaurant) { //Skip if we are comparing same index
                i = i+1
            }
            
            let comparisonRestaurant = sortedRestaurantArray[i]
            //If i is less, then the sort parameter of comparsionRestaurant should be higher than sampleRest
            if (i < indexOfSampleRestaurant && comparisonRestaurant.bestMatch < sampleRestaurant.bestMatch) {
                XCTFail("Sorting incorrect. Best match of comparison is less than best match of sample although it shouldn't")
            }
            
            else if (i > indexOfSampleRestaurant && comparisonRestaurant.bestMatch > sampleRestaurant.bestMatch) {
                XCTFail("Sorting incorrect. Best match of comparison is greater than best match of sample although it shouldn't")
            }
            
            XCTAssertTrue(true, "Sorting Successfull")
        }
        
    }
    
}
