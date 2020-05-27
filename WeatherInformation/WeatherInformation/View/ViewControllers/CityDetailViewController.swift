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
  // @IBOutlet weak var cityDetailTable: UITableView!
  @IBOutlet weak var cityDetailCollectionView: UICollectionView!
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var cityTempDescriptionLabel: UILabel!
  @IBOutlet weak var cityDayNameLabel: UILabel!
  @IBOutlet weak var cityDegreeTempLabel: UILabel!
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  
  @IBOutlet weak var cityTemeratureViewBottomConstraintConstant: NSLayoutConstraint!
  var oldContentOffset = CGPoint.zero
  
  let cityDetailViewModel = CityDetailViewModel()
  var cityID = Int()
  var weatherDeatils = [Dictionary<String, String>]()
  var weatherIcons = [Dictionary<String, UIImage>]()
  var isCelciusSelected : Bool?
  
  //MARK: - View Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpUI()
    getCityWeatherDetails()
  }
  
  func setUpUI() {
    self.cityDetailCollectionView.register(UINib.init(nibName: Constants.cityDetailWeatherInfoCell, bundle: nil), forCellWithReuseIdentifier: Constants.cityDetailWeatherInfoCell)
    cityDetailCollectionView.isPagingEnabled = true
    setUpLodingView()
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
    cityDegreeTempLabel.text = cityDetailViewModel.getCityTemperature(isCelcius:isCelciusSelected!)
    weatherIconImageView.downloaded(from: cityDetailViewModel.getCityIcon())
    weatherDeatils = cityDetailViewModel.getAllWeatherDetailsArray()
    weatherIcons = cityDetailViewModel.getAllWeatherIconArray()
    backgroundImageView.image = cityDetailViewModel.getImageForBackground()
    animateWeatherIconImage(cell : weatherIconImageView)
    self.cityDetailCollectionView.reloadData()
  }
  
  //MARK: - Method for imageView animation
  func animateWeatherIconImage(cell: UIImageView)  {
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
      cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }, completion: { finished in
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3, options: .curveEaseInOut,  animations: {
        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
      },    completion: nil
      )
    }
    )
  }
  
  //MARK: - Back to temperature list controlelr
  @IBAction func listButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
}

//MARK: - UICollectionview delegate and datasource methods
extension CityDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weatherDeatils.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cityDetailWeatherInfoCell, for: indexPath) as! CityDetailWeatherInfoCell
    for key in weatherDeatils[indexPath.row].keys {
      cell.weatherKeyLabel.text = key
      cell.weatherValueLabel.text = weatherDeatils[indexPath.row][key]
      cell.weatherIconImageView.image = weatherIcons[indexPath.row][key]
    }
    cell.backgroundContainerView.backgroundColor = cityDetailViewModel.getColourForBackground()
    animateWeatherIconImage(cell: cell.weatherIconImageView)
    return cell
  }
}

extension CityDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.size.width
    return CGSize(width: width/4, height: 160)
  }
  
}

