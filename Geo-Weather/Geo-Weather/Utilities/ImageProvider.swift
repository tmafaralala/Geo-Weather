//
//  ImageProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation
import UIKit

class ImageProvider {
    
    static let instance = ImageProvider()
    
    private init() {
        
    }
    
    var cloudy: UIImage {
        guard let cloudyImage = UIImage(named: deriveImageName(withWeather: .cloudy)) else {
            return UIImage()
        }
        return cloudyImage
    }
    
    var sunny: UIImage {
        guard let sunnyImage = UIImage(named: deriveImageName(withWeather: .sunny)) else {
            return UIImage()
        }
        return sunnyImage
    }
    
    var rainy: UIImage {
        guard let rainyImage = UIImage(named: deriveImageName(withWeather: .rainy)) else {
            return UIImage()
        }
        return rainyImage
    }
    
    private func deriveImageName(withWeather: Weather) -> String {
        let imageName = ThemeProvider.instance.theme.rawValue+"_"+withWeather.rawValue
        return imageName
    }
}
