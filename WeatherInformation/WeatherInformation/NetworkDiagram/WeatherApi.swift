//
//  WeatherApi.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

/// API URL generator
public struct WeatherApi {
  static let apiKey = "8bc22ba07ef6bd6e5cf600cf5ece4580"
  static let apiBaseUrl = "http://api.openweathermap.org/data/2.5"
  static let iconBaseUrl = "http://openweathermap.org/img/w/"
  
  static let melbourneCityId = 2158177
  static let sydneyCityId = 2147714
  static let brisbaneCityId = 2174003
  
  public static func weatherForSydneyMelbourneAndBrisbane() -> String {
    return weatherForCities(ids: 2158177, 2147714, 2174003)
  }
  
  public static func weatherForCities(ids: Int64...) -> String {
    let idString = ids.map({"\($0)"}).joined(separator: ",")
    return "\(apiBaseUrl)/group?id=\(idString)&units=metric&appid=\(apiKey)"
  }
  
  public static func weatherForPerticularCity(id: Int) -> String {
    let idString = String(id)
    return "\(apiBaseUrl)/weather?id=\(idString)&units=metric&appid=\(apiKey)"
  }
  
  public static func getURlForWeatherIcon(icon: String) -> String {
    return "\(iconBaseUrl)\(icon).png"
  }
}
