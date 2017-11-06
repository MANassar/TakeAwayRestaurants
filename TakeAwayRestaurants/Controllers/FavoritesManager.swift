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
    
    var favoriteRestaurantsArray:[Restaurant]!
    var favoriteRestaurantsJSONArray:[JSON]?
    let favoritesKey = "favoritesArray"
    
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
        if favoriteRestaurantsArray == nil || favoriteRestaurantsArray?.count == 0 {
            return false
        }
        
        for comparisonRestaurant in favoriteRestaurantsArray!
        {
            if (restaurant.name == comparisonRestaurant.name) {
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
        if !restaurantIsFavorite(restaurant: restaurant)
        {
            favoriteRestaurantsArray!.append(restaurant)
            return updateLocalStorage()
        }
        
        else {
            debugPrint("Cant add restaurant. It is already a favorite.")
            return false
        }
    }
    
    func removeRestaurantFromFavorites(restaurant:Restaurant) -> Bool
    {
        if restaurantIsFavorite(restaurant: restaurant)
        {
            let index = favoriteRestaurantsArray.index(of: restaurant)
            favoriteRestaurantsArray?.remove(at: index!)
            debugPrint("Removed restaurant from favorites")
            return updateLocalStorage()
        }
        
        else {
            debugPrint("Restaurant not in favorites")
            return false
        }
    }
    
    func clearAllFavorites()
    {
        favoriteRestaurantsArray.removeAll()
        _ = updateLocalStorage()
    }
    
    private func updateLocalStorage() -> Bool
    {
        guard let jsonArray = favoriteRestaurantsArray?.toJSONArray() else {
            UserDefaults.standard.set(nil, forKey: favoritesKey)
            UserDefaults.standard.synchronize()
            return false
        }
        
        debugPrint("New Favorites JSON array count: \(jsonArray.count)")
        
        UserDefaults.standard.set(jsonArray, forKey: favoritesKey)
        UserDefaults.standard.synchronize()
        return true
    }

    
    
}
