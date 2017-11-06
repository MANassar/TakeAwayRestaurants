//
//  RestaurantSortController.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

enum SortOptions:String {
    case BestMatch = "Best Match"
    case Newest = "Newest"
    case RatingAverage = "Rating Average"
    case Distance = "Distance"
    case Popularity = "Popularity"
    case AveragePrice = "Average Price"
    case DeliveryCost = "Delivery Cost"
    case MinCost = "Minimum Cost"
}

class RestaurantSortController
{
    //This function doesnt care whether the restaurant is favorite or not. It will just sort based on the sort parameter
    
    class func seperateRestaurantsByStatus(restaurantArray:[Restaurant]) -> (openRestaurants:[Restaurant], orderAheadRestaurants:[Restaurant], closedRestaurants:[Restaurant])
    {
        //We have 3 possible statuses in order, Open, Order Ahead, Closed
        var openRestaurants = [Restaurant]()
        var orderAheadRestaurants = [Restaurant]()
        var closedRestaurants = [Restaurant]()
        
        for restaurant in restaurantArray
        {
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
        
        return (openRestaurants, orderAheadRestaurants, closedRestaurants)
    }
    
    class func sortRestaurantSubArray(restaurantsSubArray: [Restaurant], sortOption:SortOptions) -> [Restaurant]
    {
        //First sort parameter should be status, then the sort option.
        switch sortOption
        {
        case .BestMatch:
            return restaurantsSubArray.sorted(by: {$0.bestMatch > $1.bestMatch})
        
        case .Newest:
            return restaurantsSubArray.sorted(by: {$0.newest > $1.newest})
            
        case .RatingAverage:
            return restaurantsSubArray.sorted(by: {$0.ratingAverage > $1.ratingAverage})
        
        case .Distance:
            return restaurantsSubArray.sorted(by: {$0.distance < $1.distance}) //Different because less distance is usually preferred on top
            
        case .Popularity:
            return restaurantsSubArray.sorted(by: {$0.popularity > $1.popularity})
            
        case .AveragePrice:
            return restaurantsSubArray.sorted(by: {$0.averageProductPrice > $1.averageProductPrice})
            
        case .DeliveryCost:
            return restaurantsSubArray.sorted(by: {$0.deliveryCosts < $1.deliveryCosts}) //Different because less delivery cost is usually preferred on top
        
        case .MinCost:
            return restaurantsSubArray.sorted(by: {$0.minCost < $1.minCost}) //Different because less min cost is usually preferred on top
        }
    }
    
//    This is the main function you call
    class func sortRestaurants(allRestaurantsArray: [Restaurant], sortOption: SortOptions) -> [Restaurant]
    {
        let separatedRestaurants = seperateRestaurantsByStatus(restaurantArray: allRestaurantsArray)
        let openRestaurants = separatedRestaurants.openRestaurants
        let orderAheadRestaurants = separatedRestaurants.orderAheadRestaurants
        let closedRestaurants = separatedRestaurants.closedRestaurants
        
        var sortedRestaurants = [Restaurant]()
        sortedRestaurants.append(contentsOf: sortRestaurantSubArray(restaurantsSubArray: openRestaurants, sortOption: sortOption))
        sortedRestaurants.append(contentsOf: sortRestaurantSubArray(restaurantsSubArray: orderAheadRestaurants, sortOption: sortOption))
        sortedRestaurants.append(contentsOf: sortRestaurantSubArray(restaurantsSubArray: closedRestaurants, sortOption: sortOption))
        
        return sortedRestaurants
    }
}
