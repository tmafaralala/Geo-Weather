//
//  ApiRequest.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/24.
//

import Foundation

protocol ApiRequestType: Encodable {
    var url: String {get}
    var body:
    
}
