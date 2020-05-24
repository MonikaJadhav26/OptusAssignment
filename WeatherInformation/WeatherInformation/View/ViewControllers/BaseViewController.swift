//
//  BaseViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 15/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  //MARK: - Outlets and Variables
  var activityIndicator = UIActivityIndicatorView()
  var loadingView: LoadingView! = nil
  var errorView: ErrorView! = nil
  
  //MARK: - View Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.addTapGesture()
    // Do any additional setup after loading the view.
  }
  
  func setUpLodingAndErrorView() {
         let aux = attachAuxilliaryViews()
         loadingView = aux.loading
//         errorView = aux.error
//         errorView.addRetryHandler(self, action: #selector(retryPressed))
  }
  
  //MARK: - Add tap Gesture to View
  func addTapGesture()  {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  //MARK: - Show Alert
  func showAlert(message: String, title : String, action: UIAlertAction) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
  //MARK: - Method For Adding Navigation Title
  func getTitleForView(navigationTitle : String?) {
    self.title = navigationTitle
  }
  
  //MARK: - Method Activity Indicator
  func addActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    activityIndicator.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
    activityIndicator.hidesWhenStopped = true
    view.addSubview(activityIndicator)
  }
  
  func showActivityIndicator() {
    activityIndicator.startAnimating()
  }
  
  func hideActivityIndicator() {
    activityIndicator.stopAnimating()
  }
  
  //MARK: - Method For Applying Rounded Corners to Button
  func addRoundedCornerToButton(button : UIButton) {
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.black.cgColor
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}


// AuxilliaryViewAttachment
extension UIViewController {

    /// Create, attach, layout and auxillary views, LoadingView and ErrorView
    public func attachAuxilliaryViews() -> (loading: LoadingView, error: ErrorView) {
        guard let nc = navigationController else {
            fatalError("UIViewController must belong to a UINavigationController")
        }
        let margins = nc.view.layoutMarginsGuide
        // Loading View
        let lv = LoadingView.create()
        nc.view.addSubview(lv)
      nc.view.bringSubviewToFront(lv)
        LayoutHelper.fillAndCentre(lv, margins: margins)
        // Error View
        let ev = ErrorView.create()
        nc.view.addSubview(ev)
      nc.view.bringSubviewToFront(ev)
        LayoutHelper.fillAndCentre(ev, margins: margins)
        // Hide both by default
        ev.isHidden = true
        lv.isHidden = true
        return (loading: lv, error: ev)
    }
}
