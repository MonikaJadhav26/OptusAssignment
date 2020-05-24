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
    
    if fetchAllCityTemperatureRecordsFromDB() {
      completion(.success(true))
    }else {
        
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
  }
  
  
  func storeCityTemperatureInformationInDatabase(result : [List])  {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
    print(result.count)
    
    for city in result {
    // Create City
    let entityCity = NSEntityDescription.entity(forEntityName: "City", in: appDelegate.managedObjectContext)
    let newCity = NSManagedObject(entity: entityCity!, insertInto: appDelegate.managedObjectContext)
    
    // Populate City
      newCity.setValue(city.name, forKey: "name")
      newCity.setValue(city.main.temp, forKey: "temperature")
      newCity.setValue(city.id, forKey: "id")
    
    do {
      try newCity.managedObjectContext?.save()
    } catch {
      let saveError = error as NSError
      print(saveError)
    }
  }
  }
  
  func fetchAllCityTemperatureRecordsFromDB() -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
    
    // Initialize Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "City", in: appDelegate.managedObjectContext)
    
    // Configure Fetch Request
    fetchRequest.entity = entityDescription
    
    do {
      let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
      if (result.count > 0) {
        for city in result {
          cityTempList.append((city as! NSManagedObject) as! City)
        }
        return true
      }
      
    } catch {
      let fetchError = error as NSError
      print(fetchError)
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
  
    func getCityTemperature(indexPath: IndexPath) -> String {
      return Formatters.Temp.string(from: Float(self.cityTempList[indexPath.row].temperature))

    }
  
}
