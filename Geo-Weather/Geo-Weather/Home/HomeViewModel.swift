//
//  HomeViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation

class HomeViewModel {
    private var repository: HomeRepositoryType?
    private weak var delegate: ViewModelDelegateType?
    private var themeProvider: ThemeProviderType
    private var currentWeather: GeoWeather?
    
    init(delegate: ViewModelDelegateType, repository: HomeRepositoryType) {
        self.repository = repository
        self.delegate = delegate
        themeProvider = ThemeProvider()

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
    
    var weatherImage: String? {
        guard let currentWeather = currentWeather,
              let _ = WeatherType(rawValue: String(describing: currentWeather.weather[0].main)) else {
            return nil
        }

        let weather = String(describing: currentWeather.weather[0].main)
        return themeProvider.theme.rawValue+"_"+weather.lowercased()
    }
    
    var temperature: String? {
        guard let temperature = currentWeather?.main.temp else {
            return nil
        }
        return String(format: "%.1f", temperature) + "°"
    }
    
    var outLook: String? {
        currentWeather?.weather[0].main
    }
    
    func changeTheme() {
        themeProvider.changeTheme()
    }
    
}
