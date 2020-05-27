//
//  Constants.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

import Foundation
import UIKit

struct Constants {
    
    static let cityTempCellIdentifier = "CityTemperatureTableViewCell"
    static let cityListCellIdentifier = "CityListTableViewCell"
    static let cityDetailCellIdentifier = "CityDetailTableViewCell"
    static let cityDetailViewController = "CityDetailViewController"
    static let cityTempFooterViewCell = "CityTempFooterViewCell"
    static let cityListViewController = "CityListViewController"
    static let cityDetailWeatherInfoCell = "CityDetailWeatherInfoCell"
    static let temperatureDetailsCellIdentifier = "TemperatureDetailsCell"
    static let cityDetailTempDegreeCell = "CityDetailTempDegreeCell"
    static let loadingView = "LoadingView"
    static let storyboard = "Main"
    static let temperatureListTableIdentifire = "cityTemperatureTableView"
    static let ok = "OK"
    static let errorTitle = "Error"
    static let success = "success"
    static let message = "Message"
    static let alert = "Alert"
    static let dayBackgraoundImageDetail = UIImage(named: "dayBackgroundForDetail")
    static let nightBackgraoundImageDetail = UIImage(named: "nightBackgroundForDetail")
    static let dayBackgraoundImageForTemperatureList = UIImage(named: "dayBackground")
    static let nightBackgraoundImageForTemperatureList = UIImage(named: "nightBackground")
    static let dayBackgroundColour = UIColor(red: 41/255, green: 109/255, blue: 182/255, alpha: 1)
    static let nightBackgroundColour = UIColor(red: 0/255, green: 0/255, blue: 5/255, alpha: 1)
    
    enum CurrentTime : String {
        case day = "TODAY"
        case night = "TONIGHT"
    }
    
}

