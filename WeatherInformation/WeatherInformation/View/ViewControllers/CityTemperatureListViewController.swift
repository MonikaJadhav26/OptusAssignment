//
//  CityTemperatureListViewController.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityTemperatureListViewController: BaseViewController {

  //MARK: - Outlets and Variables
  @IBOutlet weak var cityTemperatureTable: UITableView!
  let cityTempViewModel = CityTemperatureListViewModel()
  //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
      getCityTemperatureListFromURL()
     // self.cityTempViewModel.fetchAllCityTemperatureRecordsFromDB()

    }
    
  //MARK: - Method for UI setup
  func setUpUI() {
    self.navigationController?.isNavigationBarHidden = true
    self.cityTemperatureTable.register(UINib.init(nibName: Constants.cityTempCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cityTempCellIdentifier)
  }
  
  //MARK: - Call to get all data server
  func getCityTemperatureListFromURL() {
    self.showActivityIndicator()
    cityTempViewModel.fetchCityTemperatureData { result in
      switch(result) {
      case .success:
        self.activityIndicator.stopAnimating()
           self.cityTemperatureTable.reloadData()
      case .failure(let error):
                self.hideActivityIndicator()
                       self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
      }
    }
  }
  
}

//MARK: - UITableview delegate and datasource methods
extension CityTemperatureListViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cityTempViewModel.getNumberOfTotalCities(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityTempCellIdentifier, for: indexPath) as! CityTemperatureTableViewCell
    cell.accessibilityIdentifier = "cityCell_\(indexPath.row)"
    cell.cityNameLabel.text = cityTempViewModel.getCityName(indexPath : indexPath)
    cell.cityTempLabel.text = cityTempViewModel.getCityTemperature(indexPath : indexPath)
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let cityDetailViewController = UIStoryboard.init(name: Constants.storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "CityDetailViewController") as? CityDetailViewController
    cityDetailViewController?.cityID = cityTempViewModel.getCityId(indexPath : indexPath)
    self.navigationController?.pushViewController(cityDetailViewController!, animated: true)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
   
    let footerView =  Bundle.main.loadNibNamed("CityTempFooterViewCell", owner: self, options: nil)?.first as! CityTempFooterViewCell
    footerView.delegate = self
      return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 40
  }
  

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}

extension CityTemperatureListViewController : CityTempFooterViewDelegate {
 
  func degreeCelciusButtonTapped() {
    
  }
  
  func degreeFareniteButtonTapped() {
    
  }
    
  func addButtonTapped() {
    let cityListViewController = UIStoryboard.init(name: Constants.storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "CityListViewController") as? CityListViewController
    self.present(cityListViewController!, animated: true, completion: nil)
  }

}
