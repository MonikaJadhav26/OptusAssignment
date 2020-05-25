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
  static let temperatureDetailsCellIdentifier = "TemperatureDetailsCell"
  static let loadingView = "LoadingView"
  static let storyboard = "Main"
  static let appDelegate = UIApplication.shared.delegate as? AppDelegate
  static let ok = "OK"
  static let errorTitle = "Error"
  static let success = "success"
  static let message = "Message"
  static let alert = "Alert"
  static let dayBackgraoundImageDetail = UIImage(named: "dayBackgroundForDetail")
  static let nightBackgraoundImageDetail = UIImage(named: "nightBackgroundForDetail")
  static let dayBackgraoundImageForTemperatureList = UIImage(named: "dayBackground")
  static let nightBackgraoundImageForTemperatureList = UIImage(named: "nightBackground")
  
  enum CurrentTime : String {
    case day = "TODAY"
    case night = "TONIGHT"
  }
  
}


