//
//  HomeRequest.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation

class HomeRequest: ApiRequest {

    var urlString: String {
        Path.current
    }
    
    var method: HttpMethod {
        .get
    }
    
    var urlQueryParameters: [String : Any] {
        ["appid":Constants.ApiKeys.weatherApiKey.rawValue]
    }
    
}
