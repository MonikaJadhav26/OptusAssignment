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
        if let url = Bundle.main.url(forResource:"currentlist", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityInformation].self, from: data)
                self.cityAddViewModel.cityOriginalArray = jsonData
                self.cityAddViewModel.cityInformation = self.cityAddViewModel.cityOriginalArray
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func testFetchCityDetailForPErticularIsSuccess() {
        let expectation = self.expectation(description: "success")
        cityAddViewModel.fetchCityDetailWeatherForPerticularCity(cityId: 2147714) { (result) in
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
    
    func testCitySearchTextResult() {
        cityAddViewModel.searchCity(with: "Sydney") {
            XCTAssertEqual(self.cityAddViewModel.cityInformation.count, 2)
        }
        
        let searchCity = self.cityAddViewModel.cityInformation[0]
        XCTAssertEqual(searchCity.id, 2147714)
        XCTAssertEqual(searchCity.name, "Sydney")
        XCTAssertEqual(searchCity.country, "AU")
    }
    
    func testCitySearchTextResultIsNil() {
        cityAddViewModel.searchCity(with: "pppp") {
            XCTAssertEqual(self.cityAddViewModel.cityInformation.count, 0)
        }
    }
    
    override func tearDown() {
        self.cityAddViewModel.cityOriginalArray = []
        self.cityAddViewModel.cityInformation = []
    }
}
