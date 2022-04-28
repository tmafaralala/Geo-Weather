//
//  ForecastWeatherModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/27.
//

import Foundation

// MARK: - GeoWeather
struct GeoWeatherForecast: Codable {
    let forecastList: [WeatherForecast]
    enum CodingKeys: String, CodingKey {
        case forecastList = "list"
    }
}

// MARK: - List
struct WeatherForecast: Codable {
    let dt: Int
    let main: MainClass
    let weatherInfo: [WeatherInfo]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main
        case dtTxt = "dt_txt"
        case weatherInfo = "weather"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

// MARK: - Weather
struct WeatherInfo: Codable {
    let info: String

    enum CodingKeys: String, CodingKey {
        case info = "main"
    }
}

struct WeeklyForecast {
    let dayOfWeek: String
    let temperature: Double
    let weather: String
}
