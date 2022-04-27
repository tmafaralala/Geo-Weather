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
    func fetchCurrentWeatherData(completion: @escaping(CurrentWeatherResponse))
    func fetchForecastWeatherData(completion: @escaping (ForecastWeatherResponse))
}

class HomeRepository: HomeRepositoryType {
    func fetchCurrentWeatherData(completion: @escaping (CurrentWeatherResponse)) {
        let homeRequest = WeatherRequest()
        ApiClient.shared.call(with: homeRequest, for: GeoWeather.self) { result in
            completion(result)
        }
    }
    
    func fetchForecastWeatherData(completion: @escaping (ForecastWeatherResponse)) {
        let homeRequest = WeatherRequest()
        homeRequest.urlString = Path.forecast
        ApiClient.shared.call(with: homeRequest, for: GeoWeatherForecast.self) { result in
            completion(result)
        }
    }
}
