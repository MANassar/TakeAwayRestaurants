//
//  AppController.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

class AppController
{
    var jsonArray:[JSON]!
    var restaurantArray: [Restaurant]!
    
    func loadJSONFile(jsonFileName:String) -> [JSON]?
    {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: jsonFileName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url, options: .alwaysMapped)
        
        if let jsonFile = try? JSONSerialization.jsonObject(with: data!) as? JSON
        {
            jsonArray = jsonFile!["restaurants"] as? [JSON]
            return jsonArray
        }
        
        else {
            return nil
        }
    }
    
    func generateRestaurantArray(fromJSONArray: [JSON]) -> [Restaurant]
    {
        restaurantArray = [Restaurant].from(jsonArray: jsonArray)
        
        return restaurantArray
    }
    
    
}
