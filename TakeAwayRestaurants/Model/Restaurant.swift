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

class Restaurant:Decodable
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
        
    }
    
    /*
    init(name:String, status:Int, bestMatch: Float, newest:Float, ratingAverage:Float, distance: Float, popularity:Float, averagePrice:Float, deliveryCost:Float, minCost:Float)
    {
        self.name = name
        self.status = Status.init(rawValue: status)
        self.bestMatch = bestMatch
        self.newest = newest
        
    }*/
}

