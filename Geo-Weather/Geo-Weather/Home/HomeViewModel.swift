//
//  HomeViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation
import CoreData
import CoreLocation

class HomeViewModel: NSObject {
    private var repository: HomeRepositoryType?
    private weak var delegate: ViewModelDelegateType?
    private var themeProvider: ThemeProviderType!
    private var currentWeather: GeoWeather?
    private var forecastWeather: [WeeklyForecast]?
    private var loactionIsFavourite: Bool = false
    private(set) var updateTime: String = String(describing: Date())
    
    init(delegate: ViewModelDelegateType,
         repository: HomeRepositoryType) {
        super.init()
        self.repository = repository
        self.delegate = delegate
        self.themeProvider = ThemeProvider()
    }

// MARK: - Properties

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

// MARK: - Methods
    func foreCast(at: Int) -> WeeklyForecast? {
          return forecastWeather?[at]
    }
    
    func changeTheme() {
        themeProvider.changeTheme()
    }

    func fetchWeather(context: NSManagedObjectContext, lon: Double, lat: Double) {
        fetchCurrentWeather(context: context, lat: lat, lon: lon)
        fetchForecastWeather(context: context, lat: lat, lon: lon)
    }
    
    func saveLocation(context cont: NSManagedObjectContext,named location: String) {
        guard let lon = currentWeather?.coord.lon,
              let lat = currentWeather?.coord.lat else {
            return
        }

        let newLocation = FavouriteLocation(context: cont)
        newLocation.lon = lon
        newLocation.lat = lat
        newLocation.location = locationName
        newLocation.name = location
        repository?.saveLocation(context: cont) {  [weak self] result in
            self?.loactionIsFavourite = result
            self?.delegate?.reloadView()
        }
    }
    
    private func fetchCurrentWeather(context: NSManagedObjectContext, lat: Double,lon: Double) {
        if !NetworkMonitor.shared.isConnected {
            self.reloadCachedData(context: context)
            return
        }

        repository?.fetchCurrentWeatherData(lat: lat,
                                            lon: lon ) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
                self?.formatUpdateTime()
                self?.delegate?.reloadView()
                self?.cacheCurrentWeatherData(context: context)
            case .failure(let dataError):
                print(dataError)
            }
        }
    }
    
    private func fetchForecastWeather(context: NSManagedObjectContext, lat: Double,lon: Double) {
        repository?.fetchForecastWeatherData(lat: lat,
                                             lon: lon) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.forecastWeather = self?.filterWeatherData(for: weatherData.forecastList)
                self?.delegate?.reloadView()
                self?.cacheForecastWeatherData(context: context)
            case .failure(let dataError):
                print(dataError)
            }
        }
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
    
    private func cacheCurrentWeatherData(context: NSManagedObjectContext) {
        guard let name = currentWeather?.name,
              let lon = currentWeather?.coord.lon,
              let lat = currentWeather?.coord.lat,
              let countryName = currentWeather?.country.name,
              let max = currentWeather?.main.tempMax,
              let min = currentWeather?.main.tempMin,
              let temp = currentWeather?.main.temp else {
            return
        }
        let offline = OfflineCurrentWeather(context: context)
        offline.name = name
        offline.offlineCoordinates = OfflineCurrentCoordinates(context: context)
        offline.offlineCoordinates?.longitude = lon
        offline.offlineCoordinates?.latitude = lat
        formatUpdateTime()

        offline.lastCache = updateTime
        offline.offlineCountry = OfflineCountry(context: context)
        offline.offlineCountry?.name = countryName
        offline.offlineWeather = OfflineWeather(context: context)
        offline.offlineWeather?.name = self.outLook
        offline.offlineWeatherInfo = OfflineWeatherInfo(context: context)
        offline.offlineWeatherInfo?.tempMax = max
        offline.offlineWeatherInfo?.tempMin = min
        offline.offlineWeatherInfo?.temperature = temp
        repository?.cacheCurrentWeather(context: context) { result in
            print(result)
        }
    }
    
    private func cacheForecastWeatherData(context: NSManagedObjectContext) {
        guard let forecasts = forecastWeather else {
            return
        }
        for forecast in forecasts {
            let offlineForecast = OfflineWeatherForecast(context: context)
            offlineForecast.temperature = forecast.temperature
            offlineForecast.weather = forecast.weather
            offlineForecast.dayOfWeek = forecast.dayOfWeek
        }
        repository?.cacheCurrentForecast(context: context) { result in
            print(result)
        }
    }
    
    private func formatUpdateTime() {
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        updateTime = dateformat.string(from: date)
    }
    
    private func reloadCachedData(context cont: NSManagedObjectContext) {
        reloadCachedForeCastWeather(cont: cont)
        reloadCachedCurrentWeather(cont: cont)
    }
    
    private func reloadCachedForeCastWeather(cont: NSManagedObjectContext) {
        repository?.fetchCachedForecastWeather(context: cont) {[weak self] result in
            guard let forecasts = result else {
                return
            }
            self?.forecastWeather = []
            var iterator = 0
            var lastIndex = forecasts.count - 1
            while iterator <= 5 {
                let forecast = forecasts[lastIndex]
                guard let dayOfWeek = forecast.dayOfWeek,
                      let weather = forecast.weather else {
                    return
                }
                let offlineForecast = WeeklyForecast(dayOfWeek: dayOfWeek,
                                                     temperature: forecast.temperature,
                                                     weather: weather)
                self?.forecastWeather?.append(offlineForecast)
                iterator += 1
                lastIndex -= 1
            }

            self?.delegate?.reloadView()
            return
        }
    }
    
    private func reloadCachedCurrentWeather(cont: NSManagedObjectContext) {
        repository?.fetchCachedCurrentWeather(context: cont) {[weak self] result in
            guard let lon = result?.offlineCoordinates?.longitude,
                  let lat = result?.offlineCoordinates?.latitude,
                  let offlineOutlook = result?.offlineWeather?.name,
                  let temp = result?.offlineWeatherInfo?.temperature,
                  let min = result?.offlineWeatherInfo?.tempMin,
                  let max = result?.offlineWeatherInfo?.tempMax,
                  let name = result?.name,
                  let lastCache = result?.lastCache,
                  let countryName = result?.offlineCountry?.name else {
                return
            }
            self?.currentWeather = GeoWeather(coord: Coord(lon: lon, lat: lat),
                                              weather: [Weather(main: offlineOutlook)],
                                              main: Main(temp: temp, tempMin: min, tempMax: max),
                                              name: name,
                                              country: Country(name: countryName))
            self?.updateTime = lastCache
            self?.delegate?.reloadView()
            return
        }
    }
}
