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
        self.setUpLodingView()
        setUPSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getAllCitiesList()
    }
    
    //MARK: - SearchBar Setup
    func setUPSearchBar() {
        self.citySearchBar.layer.cornerRadius = 10.0
        self.citySearchBar.clipsToBounds = true
        self.citySearchBar.searchBarStyle = UISearchBar.Style.prominent
        self.citySearchBar.isTranslucent = false
        let textFieldInsideSearchBar = self.citySearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.darkGray
        self.citySearchBar.barTintColor = UIColor.black
    }
    
    //MARK: - Fetch all cities list from local file
    func getAllCitiesList() {
        loadingView.isHidden = false
        self.showActivityIndicator()
        cityAddViewModel.getAllCityDataFromLocalFile{ result in
            switch(result) {
            case .success:
                self.hideActivityIndicator()
                self.loadingView.isHidden = true
                self.cityListTable.reloadData()
            case .failure(let error):
                self.loadingView.isHidden = true
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
    //MARK: - Back to temperature list controlelr
    
    @IBAction func cancelButtonClickedAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        (cell?.contentView.viewWithTag(1) as! UILabel).text = cityAddViewModel.getCityName(indexPath : indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loadingView.isHidden = false
        tableView.deselectRow(at: indexPath, animated: true)
        let cityID = cityAddViewModel.getCityId(indexPath: indexPath)
        cityAddViewModel.fetchCityDetailWeatherForPerticularCity(cityId: cityID) { result in
            switch(result) {
            case .success:
                self.loadingView.isHidden = true
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.loadingView.isHidden = true
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
