//
//  HomeRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/25.
//

import Foundation
import CoreData

typealias CurrentWeatherResponse = ApiClientResponse<GeoWeather>
typealias ForecastWeatherResponse = ApiClientResponse<GeoWeatherForecast>

protocol HomeRepositoryType: AnyObject {
    func fetchCurrentWeatherData(lat: Double,
                                 lon: Double,
                                 completion: @escaping(CurrentWeatherResponse))

    func fetchForecastWeatherData(lat: Double,
                                  lon: Double,
                                  completion: @escaping (ForecastWeatherResponse))
    
    func saveLocation(context: NSManagedObjectContext,
                      completion: @escaping((Bool) -> Void))
    
    func cacheCurrentWeather(context: NSManagedObjectContext,
                             completion: @escaping((Bool) -> Void))
    
    func cacheCurrentForecast(context: NSManagedObjectContext,
                              completion: @escaping((Bool) -> Void))
    
    func fetchCachedCurrentWeather(context: NSManagedObjectContext,
                                   completion: @escaping((OfflineCurrentWeather?) -> Void))
    func fetchCachedForecastWeather(context: NSManagedObjectContext,
                                    completion: @escaping(([OfflineWeatherForecast]?) -> Void))
}

class HomeRepository: HomeRepositoryType {
    func fetchCurrentWeatherData(lat: Double,
                                 lon: Double,
                                 completion: @escaping (CurrentWeatherResponse)) {
        let homeRequest = WeatherRequest(lat: lat, lon: lon)
        ApiClient.shared.call(with: homeRequest, for: GeoWeather.self) { result in
            completion(result)
        }
    }
    
    func fetchForecastWeatherData(lat: Double,
                                  lon: Double,
                                  completion: @escaping (ForecastWeatherResponse)) {
        let homeRequest = WeatherRequest(lat: lat, lon: lon)
        homeRequest.urlString = Path.forecast
        ApiClient.shared.call(with: homeRequest, for: GeoWeatherForecast.self) { result in
            completion(result)
        }
    }
    
    func fetchCachedCurrentWeather(context: NSManagedObjectContext,
                                   completion: @escaping((OfflineCurrentWeather?) -> Void)) {
        do {
            let result = try context.fetch(OfflineCurrentWeather.fetchRequest())
            var index = result.count
                index -= 1
                completion(result[index])
        } catch {
            completion(nil)
        }
    }
    
    func fetchCachedForecastWeather(context: NSManagedObjectContext,
                                    completion: @escaping(([OfflineWeatherForecast]?) -> Void)) {
        do {
            let result = try context.fetch(OfflineWeatherForecast.fetchRequest())
                completion(result)
        } catch {
            completion(nil)
        }
    }
    
    func saveLocation(context: NSManagedObjectContext,
                      completion: @escaping ((Bool) -> Void)) {
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func cacheCurrentWeather(context: NSManagedObjectContext,
                             completion: @escaping((Bool) -> Void)) {
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func cacheCurrentForecast(context: NSManagedObjectContext,
                              completion: @escaping((Bool) -> Void)) {
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
