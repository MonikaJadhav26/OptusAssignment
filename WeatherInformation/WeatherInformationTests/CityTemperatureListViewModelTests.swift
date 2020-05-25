//
//  CityTemperatureListViewModelTests.swift
//  WeatherInformationTests
//
//  Created by Monika Jadhav on 25/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest
@testable import WeatherInformation


class CityTemperatureListViewModelTests: XCTestCase {

  let cityTempViewModel = CityTemperatureListViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFetchCityTEmperatureDataIsSuccess() {
      let expectation = self.expectation(description: "success")
      cityTempViewModel.fetchCityTemperatureData { (result) in
        switch(result) {
        case .success(let result):
          XCTAssertNotNil(result)
        case .failure(let error):
          XCTFail(error.localizedDescription)
        }
        expectation.fulfill()
      }
      self.waitForExpectations(timeout: 5, handler: nil)
    }

}
