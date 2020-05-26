//
//  CityWether.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//


import Foundation

// MARK: - Initial Cities Temperature List
struct InitialTemperature: Codable {
  let cnt: Int
  let list: [List]
}

// MARK: - List
struct List: Codable {
  let coord: Coord?
  let sys: Sys2?
  let weather: [Weather]?
  let main: Main?
  let visibility: Int?
  let wind: Wind?
  let clouds: Clouds?
  let dt, id: Int?
  let name: String?
}


// MARK: - CityWether
struct CityWether: Codable {
  let coord: Coord?
  let weather: [Weather]?
  let base: String?
  let main: Main?
  let visibility: Int?
  let wind: Wind?
  let clouds: Clouds?
  let dt: Int?
  let sys: Sys?
  let timezone, id: Int?
  let name: String?
  let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
  let all: Int
}

// MARK: - Coord
struct Coord: Codable {
  let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, humidity: Int?
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure, humidity
  }
}

// MARK: - Sys
struct Sys: Codable {
  let type, id: Int
  let country: String
  let sunrise, sunset: Int
}

// MARK: - Sys
struct Sys2: Codable {
  let country: String
  let timezone, sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

// MARK: - Wind
struct Wind: Codable {
  let speed: Double
  let deg: Int
}


struct CityInformation: Decodable {
    let id: Int
    let name: String
   let country: String
}
