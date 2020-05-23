//
//  TemperatureDetailsCell.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 23/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class TemperatureDetailsCell: UITableViewCell {

  @IBOutlet weak var tempKeyLabel: UILabel!
  @IBOutlet weak var tempValueLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
