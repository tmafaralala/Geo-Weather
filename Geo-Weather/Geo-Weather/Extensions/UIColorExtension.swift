//
//  UIColorExtension.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import UIKit

extension UIColor {
    static var sunny: UIColor {
        guard let sunnyColor = UIColor(named: "Sunny") else {
            return .black
        }
        return sunnyColor
    }
    
    static var cloudy: UIColor {
        guard let cloudyColor = UIColor(named: "Cloudy") else {
            return .black
        }
        return cloudyColor
    }
    
    static var rainy: UIColor {
        guard let rainyColor = UIColor(named: "Rainy") else {
            return .black
        }
        return rainyColor
    }
}
