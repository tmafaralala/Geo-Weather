//
//  ImageProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation
import UIKit

struct ImageProvider {
    var cloudy: UIImage {
        switch(ThemeProvider.instance.theme) {
        case .sea:
            guard let cloudyImage = UIImage(named: "") else {
                return UIImage()
            }
            return cloudyImage
        case .forest:
            guard let cloudyImage = UIImage(named: "") else {
                return UIImage()
            }
            return cloudyImage
        }
    }
}
