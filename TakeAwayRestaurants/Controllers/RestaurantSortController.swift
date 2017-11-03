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

class RestaurantSortController
{
    
    //This function separates favorites and non favorites.
    class func separateFavoriteRestaurants(allRestaurantsArray: [Restaurant]) -> (favorite:[Restaurant], nonFavorite:[Restaurant]) //Returns favroite and non favorite
    {
        var favoriteRestaurantsArray = [Restaurant]()
        var nonFavoriteRestarurantsArray = [Restaurant]()
        
        for restaurant in allRestaurantsArray
        {
            if (restaurant.isFavorite) {
                favoriteRestaurantsArray.append(restaurant)
            }
            
            else {
                nonFavoriteRestarurantsArray.append(restaurant)
            }
        }
        
        return (favoriteRestaurantsArray, nonFavoriteRestarurantsArray)
    }
    
    //This function doesnt care whether the restaurant is favorite or not. It will just sort based on the sort parameter
    class func sortRestaurantSubArray(restaurantsSubArray: [Restaurant], sortOption:SortOptions) -> [Restaurant]
    {
        //First sort parameter should be status, then the sort option.
        //We have 3 possible statuses in order, Open, Order Ahead, Closed
        
        var openRestaurants = [Restaurant]()
        var orderAheadRestaurants = [Restaurant]()
        var closedRestaurants = [Restaurant]()
        
        for restaurant in restaurantsSubArray {
            switch restaurant.status
            {
            case "open":
                openRestaurants.append(restaurant)
            
            case "closed":
                closedRestaurants.append(restaurant)
                
            case "order ahead":
                orderAheadRestaurants.append(restaurant)
                
            default:
                closedRestaurants.append(restaurant)
            }
        }
        
        switch sortOption
        {
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
    
//    This is the main function you call
    class func sortRestaurants(allRestaurantsArray: [Restaurant], sortOption: SortOptions) -> [Restaurant]
    {
        //First separate favorites from non favorites
        let subArrays = self.separateFavoriteRestaurants(allRestaurantsArray: allRestaurantsArray)
        let favorites = subArrays.favorite
        let nonFavorites = subArrays.nonFavorite
        
        //Sort the favorites
        var sortedArray:[Restaurant] = RestaurantSortController.sortRestaurantSubArray(restaurantsSubArray: favorites, sortOption: sortOption)
        
        //Sort the non favorites and add them to the array
        sortedArray.append(contentsOf: RestaurantSortController.sortRestaurantSubArray(restaurantsSubArray: nonFavorites, sortOption: sortOption))
        
        return sortedArray
    }
}
