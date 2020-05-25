//
//  LoadingView.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 21/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit
import QuartzCore

public class LoadingViewContainer: NSObject {
    @IBOutlet var loadingView: LoadingView!
}

public class LoadingView: UIView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

public extension LoadingView {

  static func create() -> LoadingView {
        let container = LoadingViewContainer()
        Bundle.main.loadNibNamed("LoadingView",
                                 owner: container,
                                 options: nil)
        return container.loadingView
    }
}
