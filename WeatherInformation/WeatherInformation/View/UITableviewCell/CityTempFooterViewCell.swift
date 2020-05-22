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
}

class CityTempFooterViewCell: UITableViewCell {

  var delegate: CityTempFooterViewDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
  @IBAction func addButtonClickedAction(_ sender: Any) {
          self.delegate?.addButtonTapped()
  }
}
