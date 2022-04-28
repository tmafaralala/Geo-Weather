//
//  HomeRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

typealias CurrentWeatherResponse = ApiClientResponse<GeoWeather>
typealias ForecastWeatherResponse = ApiClientResponse<GeoWeatherForecast>

protocol HomeRepositoryType: AnyObject {
    func fetchCurrentWeatherData(lat: Double,
                                 lon: Double,
                                 completion: @escaping(CurrentWeatherResponse))
    func fetchForecastWeatherData(lat: Double,
                                  lon: Double,
                                  completion: @escaping (ForecastWeatherResponse))
}

class HomeRepository: HomeRepositoryType {
    func fetchCurrentWeatherData(lat: Double,
                                 lon: Double,
                                 completion: @escaping (CurrentWeatherResponse)) {
        let homeRequest = WeatherRequest(lat: lat, lon: lon)
        ApiClient.shared.call(with: homeRequest, for: GeoWeather.self) { result in
            completion(result)
        }
    }
    
    func fetchForecastWeatherData(lat: Double,
                                  lon: Double,
                                  completion: @escaping (ForecastWeatherResponse)) {
        let homeRequest = WeatherRequest(lat: lat, lon: lon)
        homeRequest.urlString = Path.forecast
        ApiClient.shared.call(with: homeRequest, for: GeoWeatherForecast.self) { result in
            completion(result)
        }
    }
}
