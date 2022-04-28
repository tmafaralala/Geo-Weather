//
//  ApiClient.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation
import UIKit

typealias ApiClientResponse<Response> = (Result<Response,Error>) -> Void

class ApiClient {
    
    static let shared = ApiClient()
    
    private init() {
        
    }
    
    func call<Generic: Codable>(with request:ApiRequest,
                                for response: Generic.Type ,
                                completion: @escaping(ApiClientResponse<Generic>)) {
        guard let callRequest = request.build else {
            return completion(.failure(ApiError.invalidRequest))
        }
        URLSession.shared.dataTask(with: callRequest) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                return completion(.failure(ApiError.invalidResponse))
            }
            do {
                let result = try JSONDecoder().decode(response.self, from: data)
                return completion(.success(result))
            } catch {
                return completion(.failure(error))
            }
        }.resume()
    }
}
