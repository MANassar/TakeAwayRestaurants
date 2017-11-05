//
//  MainViewController.swift
//  TakeAwayRestaurants
//
//  Created by Nassar, Mohamed on 03.11.17.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var favoriteRestaurantsArray:[Restaurant]?
    var nonFavoriteRestaurantsArray:[Restaurant]?
    var gotFavorites = false
    
    let jsonFileName = "sample iOS"
    var jsonArray:[JSON]!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        refreshData()
    }

    func refreshData()
    {
        let restArray:[Restaurant] = AppController.generateRestaurantArray(fromJSONArray: jsonArray!)!
        let subArrays = AppController.getSeparatedRestaurantsArrays(generatedRestaurantArray: restArray)
        
        favoriteRestaurantsArray = RestaurantSortController.sortRestaurants(allRestaurantsArray: subArrays.favoriteRestaurants!, sortOption: .BestMatch)
        nonFavoriteRestaurantsArray = RestaurantSortController.sortRestaurants(allRestaurantsArray: subArrays.nonFavoriteRestaurants, sortOption: .BestMatch)
        
        gotFavorites = (favoriteRestaurantsArray != nil && favoriteRestaurantsArray!.count > 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, RestaurantCellDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //If we have favorites, then 2 sections, if not then 1 section
        refreshData()
        
        if (gotFavorites) {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0 && gotFavorites) {
            return favoriteRestaurantsArray!.count
        }
        else {
            return nonFavoriteRestaurantsArray!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        cell.delegate = self
        cell.restaurantFavoriteButton.isSelected = false //Clear the cell state
        
        var restaurant:Restaurant!
        
        if (indexPath.section == 0 && gotFavorites) {
            restaurant = favoriteRestaurantsArray![indexPath.row]
            cell.restaurantFavoriteButton.isSelected = true
        }
            
        else {
            restaurant = nonFavoriteRestaurantsArray![indexPath.row]
        }
        
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantStatusLabel.text = restaurant.status
        cell.restaurant = restaurant
        
        return cell
    }
    
    func addFavoritesButtonPressed(restaurantCell: RestaurantCell)
    {
        let favoritesManager = FavoritesManager.sharedManager
        if !favoritesManager.restaurantIsFavorite(restaurant: restaurantCell.restaurant)
        {
            _ = favoritesManager.addRestaurantToFavorites(restaurant: restaurantCell.restaurant)
            restaurantCell.restaurantFavoriteButton.isSelected = true
        }
        
        else {
            _ = favoritesManager.removeRestaurantFromFavorites(restaurant: restaurantCell.restaurant)
            restaurantCell.restaurantFavoriteButton.isSelected = false
        }
        
        tableView.reloadData()
    }
}
