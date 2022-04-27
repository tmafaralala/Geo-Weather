//
//  ApiRequest.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

protocol ApiRequest {
    var build: URLRequest? {get}
    var urlString: String {get set}
    var method: HttpMethod {get set}
    var headers: [String: String] {get set}
    var urlQueryParameters: [String: Any] {get set}
}

extension ApiRequest {
    var headers: [String: String] {
        [:]
    }
    
    var urlQueryParameters: [String: Any] {
        [:]
    }
    
    var build: URLRequest? {
            if var urlComponetsBuilder = URLComponents(string: urlString) {
            urlQueryParameters.forEach {
                let queryParam = URLQueryItem(name: $0.key, value: String(describing: $0.value))
                urlComponetsBuilder.queryItems?.append(queryParam)
            }
            if let url = urlComponetsBuilder.url {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method.rawValue
                urlRequest.allHTTPHeaderFields = headers
                setDefaultHeaders(requestUrl: &urlRequest)
                return urlRequest
            }
        }
        return nil
    }
    
    private func setDefaultHeaders(requestUrl: inout URLRequest) {
        Constants.DefaultHeaders.headers.forEach { header in
            requestUrl.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
}
