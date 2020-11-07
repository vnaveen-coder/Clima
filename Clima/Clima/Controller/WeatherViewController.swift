//
//  ViewController.swift
//  Clima
//
//  Created by Naveen on 05/04/20.
//  Copyright © 2020 Naveen. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var weatherManager=WeatherManager()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func loactionPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UITextField) {
        searchTextField.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city=textField.text{
            weatherManager.weatherFetchdata(cityName: city)
        }
        textField.text=""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager ,weather : Weathermodel){
        DispatchQueue.main.async{
            self.temperatureLabel.text=weather.temperatureString
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
        }
        
    }
    func didFailwithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.weatherFetchdata(latitude: lat, longitude: long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

