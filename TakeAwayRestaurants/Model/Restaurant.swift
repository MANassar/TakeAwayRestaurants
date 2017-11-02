//
//  Restaurant.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

enum Status:Int {
    case Closed = 0
    case Open = 1
    case OrderAhead = 2
}

class Restaurant:Decodable, CustomStringConvertible
{
    var name:String!
    var status:String!
    var bestMatch: Float!
    var newest: Float!
    var ratingAverage: Float!
    var distance: Float!
    var popularity: Float!
    var averageProductPrice: Float!
    var deliveryCosts: Float!
    var minCost: Float!
    var isFavorite = false
    
    var description:String {
        return "Restaurant name = \(name!), isFavorite = \(isFavorite), status = \(status!)"
    }
    
    required init?(json: JSON)
    {
        self.name = "name" <~~ json
        self.status = "status" <~~ json
        self.bestMatch = "sortingValues.bestMatch" <~~ json
        self.newest = "sortingValues.newest" <~~ json
        self.ratingAverage = "sortingValues.ratingAverage" <~~ json
        self.distance = "sortingValues.distance" <~~ json
        self.popularity = "sortingValues.popularity" <~~ json
        self.averageProductPrice = "sortingValues.averageProductPrice" <~~ json
        self.deliveryCosts = "sortingValues.deliveryCosts" <~~ json
        self.minCost = "sortingValues.minCost" <~~ json
    }
}

