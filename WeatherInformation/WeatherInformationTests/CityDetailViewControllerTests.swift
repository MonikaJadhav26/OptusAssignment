//
//  CityDetailViewControllerTests.swift
//  WeatherInformationTests
//
//  Created by Monika Jadhav on 27/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest
@testable import WeatherInformation

class CityDetailViewControllerTests: XCTestCase {
    
    let cityDetailViewModel = CityDetailViewModel()
    
    override func setUp() {
        
    }
    
    func testFetchCityTemperatureDataIsSuccess() {
        let expectation = self.expectation(description: "success")
        cityDetailViewModel.fetchCityDetailWeatherInformation(cityId: 2147714) { (result) in
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
