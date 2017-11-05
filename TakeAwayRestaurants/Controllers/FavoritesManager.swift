//
//  FavoritesManager.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 04/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

class FavoritesManager
{
    static let sharedManager = FavoritesManager()
    
    var favoriteRestaurantsArray:[Restaurant]?
    var favoriteRestaurantsJSONArray:[JSON]?
    let favoritesKey = "favoritesArray"
    
    private var favoritesPathURL:URL {
        get {
            let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.appendingPathComponent("FavoriteRestaurants.json")
        }
    }
    
    private init()
    {
        if let jsonArray = UserDefaults.standard.array(forKey: favoritesKey) as? [JSON] {
            favoriteRestaurantsJSONArray = jsonArray
            if let restArray = AppController.generateRestaurantArray(fromJSONArray: favoriteRestaurantsJSONArray!){
                favoriteRestaurantsArray = restArray
                debugPrint("Our current favorites = \(favoriteRestaurantsArray)")
            }
        }
        
        else {
            favoriteRestaurantsArray = [Restaurant]()
        }
    }
    
    //
    // Returns whether a given restaurant is already a favorite
    //
    func restaurantIsFavorite(restaurant:Restaurant) -> Bool
    {
        if restaurant.isFavorite {
            return true
        }
        
        if favoriteRestaurantsArray == nil || favoriteRestaurantsArray?.count == 0 {
            return false
        }
        
        for comparisonRestaurant in favoriteRestaurantsArray!
        {
            if (restaurant.name == comparisonRestaurant.name) {
                restaurant.isFavorite = true
                return true
            }
        }
        return false
    }
    
    //
    // Add a rest to favorites if its not already there
    //
    func addRestaurantToFavorites(restaurant:Restaurant) -> Bool
    {
        if !restaurantIsFavorite(restaurant: restaurant) {
            restaurant.isFavorite = true
            favoriteRestaurantsArray!.append(restaurant)
            guard let jsonArray = favoriteRestaurantsArray?.toJSONArray() else {
                return false
            }
            
            debugPrint("New Favorites JSON array: \(jsonArray)")
            
            UserDefaults.standard.set(jsonArray, forKey: favoritesKey)
            UserDefaults.standard.synchronize()
            return true
        }
        
        else {
            debugPrint("Cant add restaurant. It is already a favorite.")
            return false
        }
    }
    
//    func removeRestaurantFromFavorites(restaurant:Restaurant) -> Bool {
//        
//    }
//    
//    func removeRestaurantWithNameFromFavorites(restaurantName:String) -> Bool {
//        
//    }
    
}
