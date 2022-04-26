//
//  Constants.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/24.
//

import Foundation

struct Constants {
    enum ApiKeys: String {
        case weatherApiKey = "7e507330493fabb4f6e38a52bb8a358a"
    }
    
    struct DefaultHeaders {
        static let headers: [String: String] = ["Content-Type":"application/json"]
    }
}
