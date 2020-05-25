//
//  CityInformation.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation


//struct CityInformation: Decodable {
//  let id : Int?
//  let name : String?
//  let state : String?
//  let country : String?
//  let coord : [CityCoordinate]?
//}
//
//struct CityCoordinate: Decodable {
//    let lon : Double?
//    let lat : Double?
//}

/*
 struct CityInformation : Codable {
 let id : Int?
 let name : String?
 let state : String?
 let country : String?
 let coord : [Coordinate]?
 
 enum CodingKeys: String, CodingKey {
 
 case id = "id"
 case name = "name"
 case state = "state"
 case country = "country"
 case coord = "coord"
 }
 
 init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)
 id = try values.decodeIfPresent(Int.self, forKey: .id)
 name = try values.decodeIfPresent(String.self, forKey: .name)
 state = try values.decodeIfPresent(String.self, forKey: .state)
 country = try values.decodeIfPresent(String.self, forKey: .country)
 coord = try values.decodeIfPresent([Coordinate].self, forKey: .coord)
 }
 
 }
 
 struct Coordinate : Codable {
 let lon : Double?
 let lat : Double?
 
 enum CodingKeys: String, CodingKey {
 
 case lon = "lon"
 case lat = "lat"
 }
 
 init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)
 lon = try values.decodeIfPresent(Double.self, forKey: .lon)
 lat = try values.decodeIfPresent(Double.self, forKey: .lat)
 }
 
 }
 *///
//
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 22, 2020

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

