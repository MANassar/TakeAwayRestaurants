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
    
    var RestarurantArray:[Restaurant]?
    var sortedRestaurantsArray:[Restaurant]?
    
    func sortRestaurants(sortOption: SortOptions) -> [Restaurant]
    {
        //
    }
}
