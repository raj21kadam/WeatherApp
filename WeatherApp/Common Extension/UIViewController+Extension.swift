//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
    
    func showAlert(message: String, title: String? = nil)
    {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let ok_action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(ok_action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addLoader(message: String = "")
    {
        removeLoader() 
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = message
        indicator.show(animated: true)
        
    }
    
    func removeLoader()
    {
       MBProgressHUD.hide(for: self.view, animated: true)
    }
}
