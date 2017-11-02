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
        return "Restaurant name = \(name), status = \(status)"
    }
    
    required init?(json: JSON)
    {
        self.name = "name" <~~ json
        self.status = "status" <~~ json
        self.bestMatch = "bestMatch" <~~ json
        self.newest = "newest" <~~ json
        self.ratingAverage = "ratingAverage" <~~ json
        self.distance = "distance" <~~ json
        self.popularity = "popularity" <~~ json
        self.averageProductPrice = "averageProductPrice" <~~ json
        self.deliveryCosts = "deliveryCosts" <~~ json
        self.minCost = "minCost" <~~ json
    }
}

