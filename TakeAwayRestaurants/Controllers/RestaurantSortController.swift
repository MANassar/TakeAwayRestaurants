//
//  RestaurantSortController.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

enum SortOptions {
    case BestMatch
    case Newest
    case RatingAverage
    case Distance
    case Popularity
    case AveragePrice
    case DeliveryCost
    case MinCost
}

class RestaurantSortController {
    
    var favoriteRestaurantsArray: [Restaurant]?
    var nonFavoriteRestarurantsArray: [Restaurant]?
    
    private func separateFavoriteRestaurants(allRestaurantsArray: [Restaurant])
    {
        for restaurant in allRestaurantsArray
        {
            if (restaurant.isFavorite) {
                favoriteRestaurantsArray?.append(restaurant)
            }
            
            else {
                nonFavoriteRestarurantsArray?.append(restaurant)
            }
        }
    }
    
    //This function doesnt care whether the restaurant is favorite or not. It will just sort based on the sort parameter
//    private func sortRestaurantArray(restaurantsSubArray: [Restaurant], sortOption:SortOptions) -> [Restaurant]
//    {
//        
//    }
//    
//    //So the sort function will work twice.
//    func sortRestaurants(allRestaurantsArray: [Restaurant], sortOption: SortOptions) -> [Restaurant]
//    {
//        //First separate favorites from non favorites
//        self.separateFavoriteRestaurants(allRestaurantsArray: allRestaurantsArray)
//        
//        
//    }
}
