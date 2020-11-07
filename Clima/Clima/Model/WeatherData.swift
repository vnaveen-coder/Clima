//
//  WeatherData.swift
//  Clima
//
//  Created by Naveen on 05/04/20.
//  Copyright © 2020 Naveen. All rights reserved.
//

import Foundation
struct Weatherdata : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}
struct Main : Codable {
    let  temp : Double
    let  pressure : Double
    
}
struct Weather  : Codable{
    let id : Int
}
