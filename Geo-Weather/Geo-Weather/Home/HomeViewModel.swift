//
//  HomeViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation
import UIKit
import CoreLocation

class HomeViewModel: NSObject, CLLocationManagerDelegate {
    private var repository: HomeRepositoryType?
    private weak var delegate: ViewModelDelegateType?
    private var themeProvider: ThemeProviderType
    private var imageProvider: ImageProviderType
    private var currentWeather: GeoWeather?
    private lazy var locationManager = CLLocationManager()
    
    init(delegate: ViewModelDelegateType, repository: HomeRepositoryType) {
        self.repository = repository
        self.delegate = delegate
        themeProvider = ThemeProvider()
        imageProvider = ImageProvider(with: themeProvider)
    }
    
    func fetchCurrentWeather() {
        repository?.fetchCurrentWeatherData() { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
                self?.delegate?.reloadView()
            case .failure(let dataError):
                print(dataError)
                self?.delegate?.alert()
            }
        }
    }
    
    var weatherImage: UIImage? {
        guard let currentWeather = currentWeather else {
            return nil
        }

        let weather = String(describing: currentWeather.weather[0].main)
        print(weather)
        guard let weatherType = WeatherType(rawValue: weather.lowercased()) else {
            return nil
        }
        return imageProvider.image(for: weatherType)
    }
    
    func changeTheme() {
        themeProvider.changeTheme()
    }
}
