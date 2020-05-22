//
//  CityListViewController.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

  //MARK: - Outlets and Variables
   @IBOutlet weak var cityListTable: UITableView!
   
   //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

  @IBAction func cancelButtonClickedAction(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
  }
}
//MARK: - UITableview delegate and datasource methods
extension CityListViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityListCellIdentifier)
    cell?.accessibilityIdentifier = "cityCell_\(indexPath.row)"
    cell?.textLabel?.text = "Pune"
    return cell!
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
}
