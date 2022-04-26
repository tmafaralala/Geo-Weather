//
//  ImageProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation
import UIKit

protocol ImageProviderType: AnyObject {
    var themeProvider: ThemeProviderType {get}
    
    func image(for weather: WeatherType) -> UIImage?
}

class ImageProvider: ImageProviderType {
    internal var themeProvider: ThemeProviderType
    
    init(with themeProvider: ThemeProviderType) {
        self.themeProvider = themeProvider
    }
    
    internal func image(for weather: WeatherType) -> UIImage? {
        let imageName = themeProvider.theme.rawValue+"_"+weather.rawValue
        return UIImage(named: imageName)
    }
}
