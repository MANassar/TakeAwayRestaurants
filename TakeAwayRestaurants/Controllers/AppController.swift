//
//  AppController.swift
//  TakeAwayRestaurants
//
//  Created by Mohamed Nassar on 01/11/2017.
//  Copyright © 2017 Mohamed Nassar. All rights reserved.
//

import Foundation

class AppController {
    
    let jsonFileName = "sample iOS"
    var jsonArray:JSON?
    var restaurantArray: [Restaurant]!
    
    func loadJSONFile() -> Bool
    {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: jsonFileName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url, options: .alwaysMapped)
        if let jsonFile = try? JSONSerialization.jsonObject(with: data!) as! JSON
        {
            debugPrint(jsonFile)
            jsonArray = jsonFile
            return true
        }
        
        else {
            return false
        }
    }
    
    func parseJSON() {
//        restaurantArray = [Restaurant].from(jsonArray: jsonArray!)
//        debugPrint(restaurantArray)
    }
}
