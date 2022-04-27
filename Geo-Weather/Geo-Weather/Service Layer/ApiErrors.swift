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
    case invalidModel = "Request invalid, or not provided."
    case unknownError = "An unknown error occurred."
    case invalidUrl = "URL could not be parsed."
    case invalidRequest = "Request failed to build."
}
