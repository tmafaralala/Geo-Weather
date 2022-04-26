//
//  ApiPath.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/24.
//

import Foundation

let baseURL = "https://api.openweathermap.org/data/2.5/weather?"

struct Path {
    
    static var current: String {
        return "\(baseURL)/current"
    }
    
    static var forecast: String {
        return "\(baseURL)/forecast"
    }
}
