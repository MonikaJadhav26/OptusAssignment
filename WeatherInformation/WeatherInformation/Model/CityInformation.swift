//
//  CityInformation.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//


import Foundation

struct CityInformation : Codable {
  
  let coord : TempCoord?
  let country : String?
  let id : Int?
  let name : String?
  let state : String?
  
  enum CodingKeys: String, CodingKey {
    case coord = "coord"
    case country = "country"
    case id = "id"
    case name = "name"
    case state = "state"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    coord = try TempCoord(from: decoder)
    country = try values.decodeIfPresent(String.self, forKey: .country)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    state = try values.decodeIfPresent(String.self, forKey: .state)
  }
  
}
struct TempCoord : Codable {
  
  let lat : Float?
  let lon : Float?
  
  enum CodingKeys: String, CodingKey {
    case lat = "lat"
    case lon = "lon"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    lat = try values.decodeIfPresent(Float.self, forKey: .lat)
    lon = try values.decodeIfPresent(Float.self, forKey: .lon)
  }
  
}


