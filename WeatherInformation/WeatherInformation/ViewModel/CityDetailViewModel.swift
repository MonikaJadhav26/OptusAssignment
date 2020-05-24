//
//  CityDetailViewModel.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

class CityDetailViewModel : NSObject {
  
  //MARK: - Variables
  var apiClient: ApiClient = ApiClient()
  var city : [CityWether] = [CityWether]()
  
  //MARK: - Method for fetching all city temperature data
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
  
  func getCityTemperature() -> String {
    return Formatters.Temp.string(from: Float(self.city[0].main?.temp ?? 0.0))
  }

 
  func getCityIcon() -> String {
    return WeatherApi.getURlForWeatherIcon(icon: city[0].weather?[0].icon ?? "")
  }
  
  func getCityMinMaxTemperatureValues() -> String {
    
    let minMaxTempString = "\(Formatters.Temp.string(from: Float(self.city[0].main?.tempMax ?? 0.0)))  \(Formatters.Temp.string(from: Float(self.city[0].main?.tempMin ?? 0.0)))"
    
    return minMaxTempString
  }
  
  func getCityCurrentDayName() -> String {
    return city[0].name ?? ""
  }
  
  func getAllWeatherDetailsArray() -> [Dictionary<String, String>] {
    
    var weatherDeatils = [Dictionary<String, String>]()
    
    let todayForecastDetails = "\(city[0].weather?[0].weatherDescription ?? "") currently. It's\(Formatters.Temp.string(from: Float(self.city[0].main?.tempMin ?? 0.0))); the high today was forecast as \(Formatters.Temp.string(from: Float(self.city[0].main?.tempMax ?? 0.0)))."
    
    weatherDeatils.append(["Today": todayForecastDetails])
   // weatherDeatils.append(["SUNRIZE": todayForecastDetails])
   // weatherDeatils.append(["SUNSET": Formatters.sunTime.string(from: )])
   // weatherDeatils.append(["HUMIDITY": (self.city[0].main?.humidity).str])
    weatherDeatils.append(["PRESSURE": Formatters.Pressure.string(from: Float(self.city[0].main?.pressure ?? Int(0.0)))])
  //  weatherDeatils.append(["WIND": todayForecastDetails])
   // weatherDeatils.append(["FEELS LIKE": todayForecastDetails])
    
    return weatherDeatils
  }
}



