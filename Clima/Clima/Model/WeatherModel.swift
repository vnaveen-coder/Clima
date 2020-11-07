//
//  WeatherModel.swift
//  Clima
//
//  Created by Naveen on 05/04/20.
//  Copyright © 2020 Naveen. All rights reserved.
//

import Foundation
struct Weathermodel {
    var condtemp : Double
    var cityName : String
    var conditionID : Int
    
    var temperatureString : String{
        return String(format: "%.1f", condtemp)
    }
    
    var conditionName : String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
}
