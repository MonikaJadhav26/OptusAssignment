//
//  CityDetailViewController.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityDetailViewController: BaseViewController {

  //MARK: - Outlets and Variables
  @IBOutlet weak var cityDetailTable: UITableView!
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var cityTempDescriptionLabel: UILabel!
  @IBOutlet weak var cityDayNameLabel: UILabel!
  @IBOutlet weak var cityMinMaxTempLabel: UILabel!
  @IBOutlet weak var cityDegreeTempLabel: UILabel!
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var backgroundImageView: UIImageView!

  @IBOutlet weak var cityTemeratureViewBottomConstraintConstant: NSLayoutConstraint!
  var oldContentOffset = CGPoint.zero
  @IBOutlet var topViewTopConstraint: NSLayoutConstraint!

  let cityDetailViewModel = CityDetailViewModel()
  var cityID = Int()
  var weatherDeatils = [Dictionary<String, String>]()


    override func viewDidLoad() {
        super.viewDidLoad()
      self.cityDetailTable.register(UINib.init(nibName: Constants.temperatureDetailsCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.temperatureDetailsCellIdentifier)
     setUpLodingView()
      getCityWeatherDetails()
    }
    
  @objc override func retryPressed() {
    getCityWeatherDetails()
  }
  
  //MARK: - Call to get all data server
  func getCityWeatherDetails() {
    self.loadingView.isHidden = false
    cityDetailViewModel.fetchCityDetailWeatherInformation(cityId:cityID) { result in
      switch(result) {
      case .success:
        self.loadingView.isHidden = true
        self.displayWeatherDetails()
      case .failure(let error):
        self.loadingView.isHidden = true
        self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
      }
    }
  }
  
  func displayWeatherDetails() {
    cityNameLabel.text = cityDetailViewModel.getCityName()
    cityDayNameLabel.text = cityDetailViewModel.getWeekday()
    cityTempDescriptionLabel.text = cityDetailViewModel.getWeatherDiscription()
    cityDegreeTempLabel.text = cityDetailViewModel.getCityTemperature()
    cityMinMaxTempLabel.text = cityDetailViewModel.getCityMinMaxTemperatureValues()
    weatherIconImageView.downloaded(from: cityDetailViewModel.getCityIcon())
    weatherDeatils = cityDetailViewModel.getAllWeatherDetailsArray()
    backgroundImageView.image = cityDetailViewModel.getImageForBackground()
    self.cityDetailTable.reloadData()
  }

  @IBAction func listButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }

}
//MARK: - UITableview delegate and datasource methods
extension CityDetailViewController : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherDeatils.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.temperatureDetailsCellIdentifier , for: indexPath)  as! TemperatureDetailsCell
    cell.accessibilityIdentifier = "cityCell_\(indexPath.row)"
   
    for key in weatherDeatils[indexPath.row].keys {
      cell.tempKeyLabel.text = key
      cell.tempValueLabel.text = weatherDeatils[indexPath.row][key]
    }
   
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  /*
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
      //ScrollView's contentOffset differences with previous contentOffset
      let contentOffset =  scrollView.contentOffset.y - oldContentOffset.y
    
      // Scrolls UP - we compress the top view
      if contentOffset > 0 && scrollView.contentOffset.y > 0 {
        UIView.animate(withDuration: 0.5) {
          self.cityTemeratureViewBottomConstraintConstant.constant = 0
        }
      }
      
      // Scrolls Down - we expand the top view
      if contentOffset < 0 && scrollView.contentOffset.y < 0 {
           UIView.animate(withDuration: 0.5) {
                   self.cityTemeratureViewBottomConstraintConstant.constant = 0
                 }
      }
      oldContentOffset = scrollView.contentOffset
  }*/
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}

//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let height = 128 - Int(cityDetailTable?.contentOffset.y ?? 0.0)
//  self.cityTemeratureViewBottomConstraintConstant.constant = CGFloat(height)
//   }
//func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//    let height = 128 - Int(cityDetailTable?.contentOffset.y ?? 0.0)
//    if !decelerate, height <= Int(60.0), height >= Int(0.0) {
//        scrollView.setContentOffset(CGPoint(x: 0, y: 0.0), animated: true)
//    }
//}
