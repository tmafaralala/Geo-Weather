//
//  HomeRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

typealias HomeResponse = ApiClientResponse<GeoWeather>

protocol HomeRepositoryType: AnyObject {
    var request: ApiRequest {get}
    var api: ApiClientType {get}
    func fetchCurrentWeatherData(completion: @escaping(HomeResponse))
}

class HomeRepository: HomeRepositoryType {

    internal var request: ApiRequest
    internal var api: ApiClientType
    
    init(request: HomeRequest = HomeRequest(),api: ApiClientType = ApiClient()) {
        self.request = request
        self.api = api
    }
    
    func fetchCurrentWeatherData(completion: @escaping (HomeResponse)) {
        api.call(with: request, for: GeoWeather.self) { result in
            completion(result)
        }
    }
}
