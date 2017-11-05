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
    static let sharedController = AppController()
    static var jsonArray:[JSON]!
    
    //Load the JSON file from the app directory. Generates a JSON array
    class func loadJSONFile(jsonFileName:String) -> [JSON]?
    {
        let bundle = Bundle(for: self)
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
    
    //Takes the generated JSON array and generates a restaurant array
    class func generateRestaurantArray(fromJSONArray: [JSON]) -> [Restaurant]?
    {
        guard let restaurantArray = [Restaurant].from(jsonArray: fromJSONArray) else {
            return nil
        }
        
        return restaurantArray
    }
    
    
}
