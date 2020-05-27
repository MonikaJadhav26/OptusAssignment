//
//  CityDetailViewModel.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import UIKit

class CityDetailViewModel : NSObject {
  
  //MARK: - Variables
  var apiClient: ApiClient = ApiClient()
  var city : [CityWether] = [CityWether]()
  
  //MARK: - Method for fetching city temperature data
  func fetchCityDetailWeatherInformation(cityId : Int,completion: @escaping (Result<CityWether, Error>) -> Void) {
    apiClient.getAllCityDetailWeather(cityId : cityId) { (result) in
      DispatchQueue.main.async {
        switch(result) {
        case .success(let result):
          print(result)
          self.city = [result]
          completion(.success(result))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  func getCityName() -> String {
    return city[0].name!
  }
  
  func getWeatherDiscription() -> String {
    return city[0].weather?[0].weatherDescription ?? ""
  }
  
  func getCityTemperature(isCelcius : Bool) -> String {
    if isCelcius {
      return Formatters.Temp.string(from: Float(self.city[0].main?.temp ?? 0.0))
    }
    return Formatters.Temp.faraniteString(from: Float(self.city[0].main?.temp ?? 0.0))
  }
  
  
  func getImageForBackground() -> UIImage {
    if Formatters.Time.string(from: Int(self.city[0].dt ?? 0)) == Constants.CurrentTime.day.rawValue
    {
      return Constants.dayBackgraoundImageDetail!
    }
    return Constants.nightBackgraoundImageDetail!
  }
  
  func getColourForBackground() -> UIColor {
    if Formatters.Time.string(from: Int(self.city[0].dt ?? 0)) == Constants.CurrentTime.day.rawValue
    {
      return Constants.dayBackgroundColour
    }
    return Constants.nightBackgroundColour
  }
  
  func getWeekday() -> String {
    return "\(Formatters.Weekday.string(from: Int(self.city[0].dt ?? 0)))"
  }
  
  func getCityIcon() -> String {
    return WeatherApi.getURlForWeatherIcon(icon: city[0].weather?[0].icon ?? "")
  }
  
  func getCityMinMaxTemperatureValues() -> String {
    
    let minMaxTempString = "max \(Formatters.Temp.string(from: Float(self.city[0].main?.tempMax ?? 0.0)))  min \(Formatters.Temp.string(from: Float(self.city[0].main?.tempMin ?? 0.0)))"
    
    return minMaxTempString
  }
  
  //MARK: - Configure array for tableview datasource
  func getAllWeatherDetailsArray() -> [Dictionary<String, String>]  {
    
    var weatherDeatils = [Dictionary<String, String>]()
    let windString = "\(String(describing: city[0].wind!.speed)) km/h"
    weatherDeatils.append(["MAX": (Formatters.Temp.string(from: Float(self.city[0].main?.tempMax ?? 0.0)))])
    weatherDeatils.append(["MIN": (Formatters.Temp.string(from: Float(self.city[0].main?.tempMin ?? 0.0)))])
    weatherDeatils.append(["SUNRIZE": Formatters.Sunrise.string(from: city[0].sys!.sunrise)])
    weatherDeatils.append(["SUNSET": Formatters.Sunrise.string(from: city[0].sys!.sunset)])
    weatherDeatils.append(["HUMIDITY": Formatters.Humidity.string(from: Int(self.city[0].main?.humidity ?? 0))])
    weatherDeatils.append(["PRESSURE": Formatters.Pressure.string(from: Float(self.city[0].main?.pressure ?? Int(0.0)))])
    weatherDeatils.append(["WIND": windString])
    weatherDeatils.append(["FEELS LIKE": Formatters.Humidity.string(from: Int(self.city[0].main?.feelsLike ?? 0.0))])
    
    return weatherDeatils
  }
  
  func getAllWeatherIconArray() -> [Dictionary<String, UIImage>]  {
    
    var weatherIcons = [Dictionary<String, UIImage>]()
    weatherIcons.append(["MAX": (UIImage(named: "maximum")!)])
    weatherIcons.append(["MIN": (UIImage(named: "minimum")!)])
    weatherIcons.append(["SUNRIZE": (UIImage(named: "sunrise")!)])
    weatherIcons.append(["SUNSET": (UIImage(named: "sunset")!)])
    weatherIcons.append(["HUMIDITY": (UIImage(named: "humidity")!)])
    weatherIcons.append(["PRESSURE": (UIImage(named: "pressure")!)])
    weatherIcons.append(["WIND": (UIImage(named: "wind")!)])
    weatherIcons.append(["FEELS LIKE": (UIImage(named: "feelsLike")!)])
    
    return weatherIcons
  }
}



