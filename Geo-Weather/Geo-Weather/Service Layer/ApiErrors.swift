//
//  ApiErrors.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation

enum ApiError: String, Error {
    case invalidResponse = "Invalid data returned"
    case invalidBody = "Body cannot be parsed to JSON"
}
