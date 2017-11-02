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
    class func sortRestaurantSubArray(restaurantsSubArray: [Restaurant], sortOption:SortOptions) -> [Restaurant]
    {
        switch sortOption {
        case .BestMatch:
            return restaurantsSubArray.sorted(by: {$0.bestMatch > $1.bestMatch})
        
        case .Newest:
            return restaurantsSubArray.sorted(by: {$0.newest > $1.newest})
            
        case .RatingAverage:
            return restaurantsSubArray.sorted(by: {$0.ratingAverage > $1.ratingAverage})
        
        case .Distance:
            return restaurantsSubArray.sorted(by: {$0.distance > $1.distance})
            
        case .Popularity:
            return restaurantsSubArray.sorted(by: {$0.popularity > $1.popularity})
            
        case .AveragePrice:
            return restaurantsSubArray.sorted(by: {$0.averageProductPrice > $1.averageProductPrice})
            
        case .DeliveryCost:
            return restaurantsSubArray.sorted(by: {$0.deliveryCosts > $1.deliveryCosts})
        
        case .MinCost:
            return restaurantsSubArray.sorted(by: {$0.minCost > $1.minCost})
        }
    }
    
    //So the sort function will work twice.
//    func sortRestaurants(allRestaurantsArray: [Restaurant], sortOption: SortOptions) -> [Restaurant]
//    {
//        //First separate favorites from non favorites
//        self.separateFavoriteRestaurants(allRestaurantsArray: allRestaurantsArray)
//        
//        
//    }
}
