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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appController = AppController()
        let jsonArray = appController.loadJSONFile(jsonFileName: jsonFileName)
        let restArray:[Restaurant] = appController.generateRestaurantArray(fromJSONArray: jsonArray!)!
        debugPrint(RestaurantSortController.sortRestaurants(allRestaurantsArray: restArray, sortOption: .BestMatch))
        
        nonFavoriteRestaurantsArray = restArray
        
        gotFavorites = (favoriteRestaurantsArray != nil && favoriteRestaurantsArray!.count > 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITabBarDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //If we have favorites, then 2 sections, if not then 1 section
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
        var restaurant:Restaurant!
        
        if (indexPath.section == 0 && gotFavorites) {
            restaurant = favoriteRestaurantsArray![indexPath.row]
        }
        
        else {
            restaurant = nonFavoriteRestaurantsArray![indexPath.row]
        }
        
        cell.restaurantNameLabel.text = restaurant.name
        cell.restaurantStatusLabel.text = restaurant.status
        cell.restaurantFavoriteButton.isSelected = restaurant.isFavorite
        
        return cell
    }
    
    
}

class RestaurantCell:UITableViewCell {
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantStatusLabel: UILabel!
    @IBOutlet var restaurantFavoriteButton: UIButton!
}
