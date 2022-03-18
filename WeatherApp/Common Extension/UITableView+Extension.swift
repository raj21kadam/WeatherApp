//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation
import UIKit

extension UITableView{
    func register(_ cellClass: String) {
        register(UINib(nibName: cellClass, bundle: nil), forCellReuseIdentifier: cellClass)
    }
}
