//
//  CityDetailWeatherInfoCell.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 26/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityDetailWeatherInfoCell: UICollectionViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherKeyLabel: UILabel!
    @IBOutlet weak var weatherValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundContainerView.layer.cornerRadius = 5
        backgroundContainerView.layer.shadowColor = UIColor.white.cgColor
        backgroundContainerView.layer.shadowOpacity = 1
        backgroundContainerView.layer.shadowOffset = .zero
        backgroundContainerView.layer.shadowRadius = 5
    }
    
}
