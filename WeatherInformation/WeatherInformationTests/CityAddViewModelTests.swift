//
//  CityAddViewModelTests.swift
//  WeatherInformationTests
//
//  Created by Monika Jadhav on 25/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest
@testable import WeatherInformation


class CityAddViewModelTests: XCTestCase {

  let cityAddViewModel = CityAddViewModel()

    override func setUp() {
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
          do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let responseModel: [CityInformation] = try! JSONDecoder().decode([CityInformation].self, from: data)
            cityAddViewModel.cityOriginalArray = responseModel
            cityAddViewModel.cityInformation = cityAddViewModel.cityOriginalArray
          } catch {
            print("parse error: \(error.localizedDescription)")
          }
        }
        else {
          print("Invalid filename/path.")
        }
  }

   

}
