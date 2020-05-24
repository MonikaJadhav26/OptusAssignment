//
//  CityListViewController.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityListViewController: BaseViewController {

  //MARK: - Outlets and Variables
   @IBOutlet weak var cityListTable: UITableView!
   @IBOutlet weak var citySearchBar: UISearchBar!
   let cityAddViewModel = CityAddViewModel()

   
   //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
         getAllCitiesList()
    }

  func getAllCitiesList() {
    self.showActivityIndicator()
    cityAddViewModel.getAllCityDataFromLocalFile{ result in
      switch(result) {
      case .success:
        self.hideActivityIndicator()
        self.cityListTable.reloadData()
      case .failure(let error):
         self.hideActivityIndicator()
        self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
      }
    }
  }
  
  @IBAction func cancelButtonClickedAction(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
  }
}

//MARK: - UITableview delegate and datasource methods
extension CityListViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cityAddViewModel.getNumberOfTotalCities(section : section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityListCellIdentifier)
    cell?.accessibilityIdentifier = "cityCell_\(indexPath.row)"
    cell?.textLabel?.text = cityAddViewModel.getCityName(indexPath : indexPath)
    return cell!
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
}

//MARK: - UISearchBar delegate methods
extension CityListViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
    searchBar.resignFirstResponder()
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    return true
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    cityAddViewModel.searchCity(with: searchText) {
      self.cityListTable.reloadData()
      if searchText.isEmpty {
        searchBar.resignFirstResponder()
      }
    }
  }
}
