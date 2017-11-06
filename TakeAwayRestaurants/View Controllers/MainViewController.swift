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
    
    var filteredFavorites: [Restaurant]?
    var filteredNonFavorites: [Restaurant]?
    
    var gotFavorites = false
    var selectedSortOption = SortOptions.BestMatch
    
    let jsonFileName = "sample iOS"
    var jsonArray:[JSON]!
    var isFiltered = false
    
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var sortOptionsTableViewController:UITableViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        jsonArray = AppController.loadJSONFile(jsonFileName: jsonFileName)
        refreshData(isFiltered: isFiltered)
    }

    func refreshData(isFiltered: Bool)
    {
        let restArray:[Restaurant] = AppController.generateRestaurantArray(fromJSONArray: jsonArray!)!
        let subArrays = AppController.getSeparatedRestaurantsArrays(generatedRestaurantArray: restArray)
        
        favoriteRestaurantsArray = RestaurantSortController.sortRestaurants(allRestaurantsArray: subArrays.favoriteRestaurants!, sortOption: selectedSortOption)
        nonFavoriteRestaurantsArray = RestaurantSortController.sortRestaurants(allRestaurantsArray: subArrays.nonFavoriteRestaurants, sortOption: selectedSortOption)
        
        filteredFavorites = favoriteRestaurantsArray
        filteredNonFavorites = nonFavoriteRestaurantsArray
        
        if isFiltered {
            self.filterRestaurantsWithString(searchString: searchBar.text!)
        }
        
        gotFavorites = (favoriteRestaurantsArray != nil && favoriteRestaurantsArray!.count > 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "presentSortingOptionsPopover"
        {
            if let sortingOptions = segue.destination as? UITableViewController
            {
                sortOptionsTableViewController = sortingOptions
                sortOptionsTableViewController!.tableView.delegate = self
                sortOptionsTableViewController!.modalPresentationStyle = UIModalPresentationStyle.popover
                sortOptionsTableViewController!.popoverPresentationController!.delegate = self
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, RestaurantCellDelegate, UIPopoverPresentationControllerDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //If we have favorites, then 2 sections, if not then 1 section
        refreshData(isFiltered: isFiltered)
        
        if (gotFavorites) {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == mainTableView
        {
            if (section == 0 && gotFavorites) {
                return filteredFavorites!.count
            }
            else {
                return filteredNonFavorites!.count
            }
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        cell.delegate = self
        cell.restaurantFavoriteButton.isSelected = false //Clear the cell state
        
        var restaurant:Restaurant!
        
        if (indexPath.section == 0 && gotFavorites) {
            restaurant = filteredFavorites![indexPath.row]
            cell.restaurantFavoriteButton.isSelected = true
        }
            
        else {
            restaurant = filteredNonFavorites![indexPath.row]
        }
        
        cell.restaurant = restaurant
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantStatusLabel.text = restaurant.status
        
        
        var restaurantSortValue:Float!
        
        switch selectedSortOption
        {
            case .BestMatch:
                restaurantSortValue = restaurant.bestMatch
            case .AveragePrice:
                restaurantSortValue = restaurant.averageProductPrice
            case .DeliveryCost:
                restaurantSortValue = restaurant.deliveryCosts
            case .Distance:
                restaurantSortValue = restaurant.distance
            case .MinCost:
                restaurantSortValue = restaurant.minCost
            case .Newest:
                restaurantSortValue = restaurant.newest
            case .Popularity:
                restaurantSortValue = restaurant.popularity
            case .RatingAverage:
                restaurantSortValue = restaurant.ratingAverage
        }
        
        cell.restaurantSortValueLabel.text = "\(selectedSortOption.rawValue): \(restaurantSortValue!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == sortOptionsTableViewController?.tableView {
            let cell = tableView.cellForRow(at: indexPath)
            let sortingOptionString = cell?.textLabel?.text
            selectedSortOption = SortOptions(rawValue: sortingOptionString!)!
            self.dismiss(animated: true, completion: nil) //Dismiss the popover
            mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0 && gotFavorites) {
            return "Favorite Restaurants"
        }
        else {
            return "Restaurants"
        }
    }
    
    //
    // MARK: Restaurant Cell Delegate
    //
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
        
        mainTableView.reloadData()
    }
    
    //
    // MARK: Popover Delegate
    //
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

//
// MARK: Extension with seach handling and filtering
//
extension MainViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
        filterRestaurantsWithString(searchString: searchText)
        mainTableView.reloadData()
    }
    
    func filterRestaurantArrayWithString(originalArray: [Restaurant], searchString: String) -> [Restaurant]
    {
        let filteredArray = originalArray.filter { (restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchString.lowercased())
        }
        
        return filteredArray
    }
    
    //This should filter both the favorites and the non favorites
    func filterRestaurantsWithString(searchString: String)
    {
        if searchString == ""
        {
            filteredFavorites = favoriteRestaurantsArray
            filteredNonFavorites = nonFavoriteRestaurantsArray
            isFiltered = false
        }
        
        else
        {
            isFiltered = true
            
            filteredFavorites = filterRestaurantArrayWithString(originalArray: favoriteRestaurantsArray!, searchString: searchString)
            filteredNonFavorites = filterRestaurantArrayWithString(originalArray: nonFavoriteRestaurantsArray!, searchString: searchString)
        }
    }
}
