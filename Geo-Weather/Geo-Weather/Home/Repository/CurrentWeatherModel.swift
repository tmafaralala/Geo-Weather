//
//  HomeModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

// MARK: - GeoWeather
struct GeoWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
    let country: Country
    enum CodingKeys: String, CodingKey {
        case coord , weather, main, name
        case country = "sys"
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

struct Country: Codable {
    let name: String
    enum CodingKeys: String, CodingKey {
        case name = "country"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let main: String
}
