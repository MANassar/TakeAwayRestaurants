//
//  RestaurantCell.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 05/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import UIKit

class RestaurantCell:UITableViewCell
{
    weak var restaurant:Restaurant!
    weak var delegate:RestaurantCellDelegate?
    
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantStatusLabel: UILabel!
    @IBOutlet var restaurantFavoriteButton: UIButton!
    
    @IBAction func addFavoritesButtonTapped(_ sender: UIButton)
    {
        debugPrint("Add favorites button tapped")
        delegate?.addFavoritesButtonPressed(restaurantCell: self)
    }
}

protocol RestaurantCellDelegate:class {
    func addFavoritesButtonPressed(restaurantCell:RestaurantCell)
}
