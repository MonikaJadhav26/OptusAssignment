//
//  CityAddViewModel.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

class CityAddViewModel : NSObject {
  
  //MARK: - Variables
  var apiClient: ApiClient = ApiClient()
  var cityInformation : [CityInformation] = [CityInformation]()
  var cityOriginalArray : [CityInformation] = [CityInformation]()
  var citySearchedArray : [CityInformation] = [CityInformation]()
  
  
  func searchCity(with searchText: String, completion: @escaping () -> Void) {
          if !searchText.isEmpty {
              citySearchedArray = self.cityOriginalArray
              self.cityInformation = citySearchedArray.filter({ $0.name!.lowercased().contains(searchText.lowercased())})
          } else {
              self.cityInformation = self.cityOriginalArray
          }
    completion()
  }
  
//  func getAllCityDataFromLocalFile() {
//    let url = Bundle.main.url(forResource: "cityList", withExtension: "json")!
//    let data = try! Data(contentsOf: url)
//    let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
//    if let jsonArray = JSON as? [[String: Any]] {
//      for item in jsonArray {
//        cityOriginalArray.append(item)
//      }
//    }
//  }
  
  func getAllCityDataFromLocalFile(completion: @escaping (Result<Bool, Error>) -> Void) {
    if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let responseModel: [CityInformation] = try! JSONDecoder().decode([CityInformation].self, from: data)
        self.cityOriginalArray = responseModel
        self.cityInformation = self.cityOriginalArray
        completion(.success(true))
      } catch {
        print("parse error: \(error.localizedDescription)")
        completion(.failure(error))
      }
    }
    else {
      print("Invalid filename/path.")
    }
  }
  
  func getNumberOfTotalCities(section: Int) -> Int {
      return self.cityInformation.count
  }
  
  func getCityName(indexPath: IndexPath) -> String {
      return self.cityInformation[indexPath.row].name ?? ""
  }
  
}
