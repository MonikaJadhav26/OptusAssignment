//
//  CityTempFooterViewCell.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

protocol CityTempFooterViewDelegate {
  func addButtonTapped()
  func degreeCelciusButtonTapped(sender: UIButton)
  func degreeFareniteButtonTapped(sender: UIButton)
}


class CityTempFooterViewCell: UITableViewCell {
  
  //MARK: - Outlets and Variables
  
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var celciusButton: UIButton!
  @IBOutlet weak var faraniteButton: UIButton!
  
  
  var delegate: CityTempFooterViewDelegate? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addButton.layer.cornerRadius = addButton.frame.size.width / 2
    addButton.layer.borderWidth = 1
    addButton.layer.borderColor = UIColor.white.cgColor
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func addButtonClickedAction(_ sender: Any) {
    self.delegate?.addButtonTapped()
  }
  @IBAction func degreeCelciusButtonClickedAction(_ sender: Any) {
    self.delegate?.degreeCelciusButtonTapped(sender: sender as! UIButton)
  }
  @IBAction func degreeFareniteClickedAction(_ sender: Any) {
    self.delegate?.degreeFareniteButtonTapped(sender: sender as! UIButton)
  }
}
