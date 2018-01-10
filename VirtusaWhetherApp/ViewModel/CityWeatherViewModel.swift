//
//  CityWeatherViewModel.swift
//  VirtusaWhetherApp
//
//  Created by Surendra Singh on 1/8/18.
//  Copyright © 2018 Surendra Singh. All rights reserved.
//

import UIKit

class CityWeatherViewModel: NSObject {
    
    //Dummy data from json file
    func readJSONDataFromFile(fileName:String, completionHandler:@escaping(CityWeather?,Error?) -> Void){
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        do{
            let cityWeather = try decoder.decode(CityWeather.self, from: data)
            completionHandler(cityWeather, nil )
        }catch let error{
            completionHandler(nil, error )
        }
    }
    
    //Fetch data from server and map to Object
    func fetchWeatherData(forCity:String, completionHandler:@escaping(CityWeather?,Error?) -> Void){
        APIService.shared.getWeatherDetails(forCity: forCity) { (data, error) in
            if let error = error{
                completionHandler(nil, error)
            }else{
                let decoder = JSONDecoder()
                do{
                    let cityWeather = try decoder.decode(CityWeather.self, from: data!)
                    completionHandler(cityWeather, nil )
                }catch let error{
                    completionHandler(nil, error )
                }
            }
        }
    }
}
