//
//  UItextField+Extension.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation
import UIKit
import Combine
extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
               object: self
        )
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
    
    func setBottomBorder(withColor color: UIColor = .gray)
    {
        self.borderStyle = .none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.5
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}
