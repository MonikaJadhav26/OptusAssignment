//
//  CityTemperatureListViewModel.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class CityTemperatureListViewModel : NSObject {
  
  //MARK: - Variables
  var apiClient: ApiClient = ApiClient()
  var cityTempList = Array<City>()
  
  
  //MARK: - Method for fetching all city temperature data
  func fetchCityTemperatureData(completion: @escaping (Result<Bool, Error>) -> Void) {
    apiClient.getInitialCitiesTemperatureList { (result) in
      DispatchQueue.main.async {
        switch(result) {
        case .success(let result):
          self.storeCityTemperatureInformationInDatabase(result: result.list)
          completion(.success(true))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  func storeCityTemperatureInformationInDatabase(result : [List])  {
    
    for city in result {
      CoreDataManager.sharedManager.insertCity(name: city.name ?? "", id: city.id ?? 0, temperature: city.main?.temp ?? 0.0, currentTime: Formatters.Sunrise.string(from: city.dt ?? 0))
    }
    
  }
  
  func fetchAllCityTemperatureRecordsFromDB() -> Bool {
    cityTempList.removeAll()
    cityTempList = CoreDataManager.sharedManager.fetchAllCities()
    if cityTempList.count > 0 {
      return true
    }
    return false
  }
  
  func getNumberOfTotalCities(section: Int) -> Int {
    return self.cityTempList.count
  }
  
  func getCityName(indexPath: IndexPath) -> String {
    return self.cityTempList[indexPath.row].name ?? ""
  }
  
  func getCityId(indexPath: IndexPath) -> Int {
    return Int(self.cityTempList[indexPath.row].id)
  }
  
  func getCityCurrentTime(indexPath: IndexPath) -> String {
    return self.cityTempList[indexPath.row].currentTime 
  }
  
  func getCityCurrentBAckgroundImage(indexPath: IndexPath) -> UIImage  {
    
    if Formatters.CurrentTimeForCity.string(from: self.cityTempList[indexPath.row].currentTime) == Constants.CurrentTime.day.rawValue {
      return Constants.dayBackgraoundImageDetail!
    }
    return Constants.nightBackgraoundImageDetail!

  }
  
  func getCityTemperature(indexPath: IndexPath) -> String {
    return Formatters.Temp.string(from: Float(self.cityTempList[indexPath.row].temperature))
  }
  
  func getCityTemperatureInFaranite(indexPath: IndexPath) -> String {
    return Formatters.Temp.faraniteString(from: Float(self.cityTempList[indexPath.row].temperature))
  }
  
}


