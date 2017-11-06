//
//  TakeAwayRestaurantsTests.swift
//  TakeAwayRestaurantsTests
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import XCTest
@testable import TakeAwayRestaurants

class TakeAwayRestaurantsTests: XCTestCase
{
    var jsonFileName:String!
    var favoritesManager:FavoritesManager!
    var mainVC:MainViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        jsonFileName = "sample iOS"
        favoritesManager = FavoritesManager.sharedManager
        mainVC = MainViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        jsonFileName = nil
        favoritesManager.clearAllFavorites()
        favoritesManager = nil
        mainVC = nil
        
        super.tearDown()
    }
    
    func testJSONPathCanLoad()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        XCTAssertNotNil(jsonArray, "We couldnt load JSON")
        
    }
    
    
    //This function checks that we actually have restaurants and whether the restaruant array count matches the JSON array count
    func testRestaurantCountMatchesJSONCount()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = AppController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        XCTAssertEqual(jsonArray?.count, restaurantArray.count)
    }
    
    func testRestaurantSort()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = AppController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
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
    
    func testAddFavorites()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = AppController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        if favoritesManager.restaurantIsFavorite(restaurant: restaurantArray.first!) {
            XCTFail("Restaurant is already in favorites")
        }
        
        _ = favoritesManager.addRestaurantToFavorites(restaurant: restaurantArray.first!)
        
        XCTAssertTrue(favoritesManager.restaurantIsFavorite(restaurant: restaurantArray.first!))
    }
    
    func testRemoveFavorite()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = AppController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        let restaurant = restaurantArray.first!
        
        if favoritesManager.restaurantIsFavorite(restaurant: restaurant) {
            XCTFail("Restaurant is already in favorites")
        }
        
        //Add the restaurat to favs
        _ = favoritesManager.addRestaurantToFavorites(restaurant: restaurant)
        
        //Confirm it is added
        if !favoritesManager.restaurantIsFavorite(restaurant: restaurant) {
            XCTFail("Restaurant was not added to favorites")
        }
        
        //Remove the restaurant from favs
        _ = favoritesManager.removeRestaurantFromFavorites(restaurant: restaurant)
        
        //Make sure it is removed
        XCTAssertFalse(favoritesManager.restaurantIsFavorite(restaurant: restaurant))
    }
    
    func testFiltering()
    {
        let jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        guard let restaurantArray = AppController.generateRestaurantArray(fromJSONArray: jsonArray!) else {
            XCTFail("Couldnt parse JSON")
            return
        }
        
        let restaurant = restaurantArray.first!
        let filterText = restaurant.name //We will filter by the while resturant name, this way we expect toget only this restaurant
        
        let filteredArray = mainVC.filterRestaurantArrayWithString(originalArray: restaurantArray, searchString: filterText!)
        
        XCTAssertTrue(filteredArray.count == 1 && filteredArray.contains(restaurant))
    }
}
