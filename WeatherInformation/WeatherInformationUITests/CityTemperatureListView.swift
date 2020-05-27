//
//  CityTemperatureListView.swift
//  WeatherInformationUITests
//
//  Created by Monika Jadhav on 27/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest

class CityTemperatureListView: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testForTableviewExistence() {
        app.launch()
        let temperatureTableView = app.tables["cityTemperatureTableView"]
        XCTAssertTrue(temperatureTableView.exists, "The temperature tableview exists")
    }
    
    func testForTableViewCellExistence() {
        app.launch()
        let temperatureTableView = app.tables["cityTemperatureTableView"]
        XCTAssertTrue(temperatureTableView.exists, "The temperature tableview exists")
        temperatureTableView.cells.containing(.staticText, identifier: "myCell_0")
    }
    
}
