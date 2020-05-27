//
//  CityAddViewModel.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CityAddViewModel : NSObject {
  
  //MARK: - Variables
  var apiClient: ApiClient = ApiClient()
  var cityInformation : [CityInformation] = [CityInformation]()
  var cityOriginalArray : [CityInformation] = [CityInformation]()
  var citySearchedArray : [CityInformation] = [CityInformation]()
  
  //MARK: - Method for search perticular city
  func searchCity(with searchText: String, completion: @escaping () -> Void) {
    if !searchText.isEmpty {
      citySearchedArray = self.cityOriginalArray
      self.cityInformation = citySearchedArray.filter({ $0.name.lowercased().contains(searchText.lowercased())})
    } else {
      self.cityInformation = self.cityOriginalArray
    }
    completion()
  }
  
  //MARK: - Method for fetching all cities list from local file
  func getAllCityDataFromLocalFile(completion: @escaping (Result<Bool, Error>) -> Void) {
    if let url = Bundle.main.url(forResource:"currentlist", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([CityInformation].self, from: data)
        self.cityOriginalArray = jsonData
        self.cityInformation = self.cityOriginalArray
        completion(.success(true))
      } catch {
        print("error:\(error)")
      }
    }
  }
  
  //MARK: - Method for fetching city temperature data
  func fetchCityDetailWeatherForPerticularCity(cityId : Int,completion: @escaping (Result<Bool, Error>) -> Void) {
    apiClient.getAllCityDetailWeather(cityId : cityId) { (result) in
      DispatchQueue.main.async {
        switch(result) {
        case .success(let result):
          self.storeCityTemperatureInformationInDatabase(result: [result])
          completion(.success(true))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  func storeCityTemperatureInformationInDatabase(result : [CityWether])  {
    for city in result {
      CoreDataManager.sharedManager.insertCity(name: city.name ?? "", id: city.id ?? 0, temperature: city.main?.temp ?? 0.0 ,currentTime: Formatters.Sunrise.string(from: city.dt ?? 0), timezone: city.timezone ?? 0)
    }
  }
  
  func getNumberOfTotalCities(section: Int) -> Int {
    return self.cityInformation.count
  }
  
  func getCityId(indexPath: IndexPath) -> Int {
    return self.cityInformation[indexPath.row].id
  }
  
  func getCityName(indexPath: IndexPath) -> String {
    return "\(self.cityInformation[indexPath.row].name ), \(self.cityInformation[indexPath.row].country )"
  }
  
}
