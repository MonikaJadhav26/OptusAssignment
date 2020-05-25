//
//  LayoutHelper.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//


import UIKit

public class LayoutHelper {

    /// Fill a view to the margins and center it
    public static func fillAndCentre(_ view: UIView, margins: UILayoutGuide) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}
