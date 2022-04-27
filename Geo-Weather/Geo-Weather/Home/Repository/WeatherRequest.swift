//
//  HomeRequest.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation
import CoreLocation

class WeatherRequest: NSObject,CLLocationManagerDelegate,ApiRequest {

    private let locationManager = CLLocationManager()
    private var lat: Double = 0.0
    private var lon: Double = 0.0
    private var url: String!
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.url = Path.current
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
             "lat"      : locationManager.location?.coordinate.latitude ?? 0.0,
             "lon"      : locationManager.location?.coordinate.longitude ?? 0.0
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
