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
    apiClient.getAllCityTemperatureList { (result) in
      DispatchQueue.main.async {
        switch(result) {
        case .success(let result):
          self.storeCityTemperatureInformationInDatabase(result: result)
          completion(.success(true))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  
  func storeCityTemperatureInformationInDatabase(result : CityWether)  {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
    // Create City
    let entityCity = NSEntityDescription.entity(forEntityName: "City", in: appDelegate.managedObjectContext)
    let newCity = NSManagedObject(entity: entityCity!, insertInto: appDelegate.managedObjectContext)
    
    // Populate City
    newCity.setValue(result.name, forKey: "name")
    newCity.setValue(result.main?.temp, forKey: "temperature")
    newCity.setValue(result.id, forKey: "id")
    
    do {
      try newCity.managedObjectContext?.save()
    } catch {
      let saveError = error as NSError
      print(saveError)
    }
  }
  
  func fetchAllCityTemperatureRecordsFromDB() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
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
      }
      
    } catch {
      let fetchError = error as NSError
      print(fetchError)
    }
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
