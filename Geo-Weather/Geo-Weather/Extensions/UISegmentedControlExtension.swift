//
//  UISegmentedControlExtension.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func addBorder() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5.0
    }
}
