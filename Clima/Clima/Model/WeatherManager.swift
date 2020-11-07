//
//  WeatherManager.swift
//  Clima
//
//  Created by Naveen on 05/04/20.
//  Copyright © 2020 Naveen. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager ,weather : Weathermodel)
    func didFailwithError(error: Error)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=43d227f8bf63aa996684f8afdedcd81f&units=metric"
    var delegate:WeatherManagerDelegate?
    func weatherFetchdata(cityName : String) {
        let urlString="\(weatherURL)&q=\(cityName)"
        performURL(with: urlString)
    }
    func weatherFetchdata(latitude: CLLocationDegrees ,longitude : CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performURL(with: urlString)
    }
    
    func performURL(with Urlstring : String )  {
        if let url = URL(string: Urlstring){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailwithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.ParseData(weatherdata: safeData){
                        self.delegate?.didUpdateWeather(self, weather : weather)
                    }
                }
            }
            task.resume()
        }
    }
    func ParseData(weatherdata : Data)-> Weathermodel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Weatherdata.self, from: weatherdata)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let weather = Weathermodel(condtemp: temp, cityName: name, conditionID: id)
            return weather
        }catch{
            delegate?.didFailwithError(error: error)
            return nil
        }
    }
    
}
