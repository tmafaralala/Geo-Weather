//
//  HomeRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

typealias HomeResponse = ApiClientResponse<GeoWeather>

protocol HomeRepositoryType: AnyObject {
    func fetchCurrentWeatherData(completion: @escaping(HomeResponse))
}

class HomeRepository: HomeRepositoryType {
    func fetchCurrentWeatherData(completion: @escaping (HomeResponse)) {
        let homeRequest = CurrentWeatherRequest()
        ApiClient.shared.call(with: homeRequest, for: GeoWeather.self) { result in
            print(result)
            completion(result)
        }
    }
}
