//
//  HomeRequest.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

class WeatherRequest: ApiRequest {

    private var lat: Double = 0.0
    private var lon: Double = 0.0
    private var url: String!
    
    init(lat: Double,
         lon: Double,
         url: String? = Path.current) {
        self.lat = lat
        self.lon = lon
        if let url = url {
            self.url = url
        }
    }
    
    var urlString: String {
        get {url}
        set (path) {self.url = path}
    }
    
    var method: HttpMethod {
        get {.get}
        set (httpMethod) {self.method = httpMethod}
    }
    
    var urlQueryParameters: [String : Any] {
        get {
            ["appid"    : Constants.ApiKeys.weatherApiKey.rawValue,
             "units"    : "metric",
             "lat"      : lat,
             "lon"      : lon
            ]
        }
        set (params) {
            self.urlQueryParameters = params
        }
    }
    
    var headers: [String : String] {
        get {[:]}
        set (headers) {
            self.headers = headers
        }
    }

}
