//
//  HomeViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation
import CoreLocation

class HomeViewModel: NSObject,CLLocationManagerDelegate {
    private var repository: HomeRepositoryType?
    private weak var delegate: ViewModelDelegateType?
    private var themeProvider: ThemeProviderType!
    private var currentWeather: GeoWeather?
    private var forecastWeather: [WeeklyForecast]?
    
    private let locationManager = CLLocationManager()
    
    init(delegate: ViewModelDelegateType, repository: HomeRepositoryType) {
        super.init()
        self.repository = repository
        self.delegate = delegate
        self.themeProvider = ThemeProvider()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var minTemp: String? {
        guard let temperature = currentWeather?.main.tempMin else {
            return nil
        }
        return String(format: "%.1f", temperature) + "°"
    }
    
    var maxTemp: String? {
        guard let temperature = currentWeather?.main.tempMax else {
            return nil
        }
        return String(format: "%.1f", temperature) + "°"
    }
    
    var outLook: String? {
        currentWeather?.weather[0].main
    }
    
    var locationName: String {
        (currentWeather?.name ?? "")+", "+(currentWeather?.country.name ?? "")
    }
    
    var weatherImage: String? {
        guard let currentWeather = currentWeather,
              let _ = WeatherType(rawValue: String(describing: currentWeather.weather[0].main).lowercased()) else {
            return nil
        }

        let weather = String(describing: currentWeather.weather[0].main)
        return themeProvider.theme.rawValue+"_"+weather.lowercased()
    }
    
    var currTemp: String? {
        guard let temperature = currentWeather?.main.temp else {
            return nil
        }
        return String(format: "%.1f", temperature) + "°"
    }
    
    var forecastCount: Int {
        forecastWeather?.count ?? 0
    }
    
    func foreCast(at: Int) -> WeeklyForecast? {
          return forecastWeather?[at]
    }
    
    func fetchCurrentWeather() {
        repository?.fetchCurrentWeatherData(lat: locationManager.location?.coordinate.latitude ?? 0.0,
                                            lon: locationManager.location?.coordinate.longitude ?? 0.0 ) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
                self?.fetchForecastWeather()
            case .failure(let dataError):
                
                print(dataError)
                self?.delegate?.alert()
            }
        }
    }
    
    func fetchForecastWeather() {
        repository?.fetchForecastWeatherData(lat: locationManager.location?.coordinate.latitude ?? 0.0,
                                             lon: locationManager.location?.coordinate.longitude ?? 0.0) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.forecastWeather = self?.filterWeatherData(for: weatherData.forecastList)
                self?.delegate?.reloadView()
            case .failure(let dataError):
                print(dataError)
                self?.delegate?.alert()
            }
        }
    }
        
    func changeTheme() {
        themeProvider.changeTheme()
    }
    
    private func filterWeatherData(for data: [WeatherForecast]) -> [WeeklyForecast] {
        var iterator = 0
        var filterData: [WeeklyForecast] = []
        while iterator != 5 {
            let currentItem = data[iterator*8]
            guard let day = NSDate(timeIntervalSince1970: TimeInterval(currentItem.dt)).day() else {
                continue
            }
            let newDay = WeeklyForecast(dayOfWeek: day,
                                        temperature: currentItem.main.temp,
                                        weather: currentItem.weatherInfo[0].info)
            filterData.append(newDay)
            iterator += 1
        }
        return filterData
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       fetchCurrentWeather()
    }
}
