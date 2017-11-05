//
//  Restaurant.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

struct RestaurantKeys
{
    static let nameKey = "name"
    static let statusKey = "status"
    static let bestMatchKey = "sortingValues.bestMatch"
    static let newestKey = "sortingValues.newest"
    static let ratingAverageKey = "sortingValues.ratingAverage"
    static let distanceKey = "sortingValues.distance"
    static let popularityKey = "sortingValues.popularity"
    static let averageProductPriceKey = "sortingValues.averageProductPrice"
    static let deliveryCostsKey = "sortingValues.deliveryCosts"
    static let minCostKey = "sortingValues.minCost"
    static let isFavoriteKey = "isFavorite"
}

class Restaurant:Decodable, Encodable, CustomStringConvertible, Equatable
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
    
    var description:String {
        return "Restaurant name = \(name!), status = \(status!), bestMatch = \(bestMatch)\n"
    }
    
    required init?(json: JSON)
    {
        self.name = RestaurantKeys.nameKey <~~ json
        self.status = RestaurantKeys.statusKey <~~ json
        self.bestMatch = RestaurantKeys.bestMatchKey <~~ json
        self.newest = RestaurantKeys.newestKey <~~ json
        self.ratingAverage = RestaurantKeys.ratingAverageKey <~~ json
        self.distance = RestaurantKeys.distanceKey <~~ json
        self.popularity = RestaurantKeys.popularityKey <~~ json
        self.averageProductPrice = RestaurantKeys.averageProductPriceKey <~~ json
        self.deliveryCosts = RestaurantKeys.deliveryCostsKey <~~ json
        self.minCost = RestaurantKeys.minCostKey <~~ json
    }
    
    func toJSON() -> JSON?
    {
        return jsonify([
            RestaurantKeys.nameKey ~~> self.name,
            RestaurantKeys.statusKey ~~> self.status,
            RestaurantKeys.bestMatchKey ~~> self.bestMatch,
            RestaurantKeys.newestKey ~~> self.newest,
            RestaurantKeys.ratingAverageKey ~~> self.ratingAverage,
            RestaurantKeys.distanceKey ~~> self.distance,
            RestaurantKeys.popularityKey ~~> self.popularity,
            RestaurantKeys.averageProductPriceKey ~~> self.averageProductPrice,
            RestaurantKeys.deliveryCostsKey ~~> self.deliveryCosts,
            RestaurantKeys.minCostKey ~~> self.minCost,
            ])
    }
    
    //
    // MARK: Equatable protocol
    //
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return (lhs.name == rhs.name)
    }
}

