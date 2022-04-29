//
//  Geo_WeatherTests.swift
//  Geo-WeatherTests
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import XCTest
@testable import Geo_Weather
import CoreData

class LoadCurrentWeather_Tests: XCTestCase {
    
    private var testHomeRepository: MockHomeRepository!
    private var testModelDelegate: MockHomeDelegate!
    private var testViewModel: HomeViewModel!
    
    
    override func setUp() {
        self.testHomeRepository = MockHomeRepository()
        self.testModelDelegate = MockHomeDelegate()
        self.testViewModel = HomeViewModel(delegate: testModelDelegate,
                                           repository: testHomeRepository)
    }
    
    func testFetchWeatherData(){
        testHomeRepository.testSuccess = true
       
    }
    
}

class MockHomeRepository: HomeRepositoryType {
    
    var testSuccess = false
    
    private enum DaysOfTheWeek: String,CaseIterable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
    }
    
    private let mockCurrentWeatherData: GeoWeather
    private let mockOfflineCurrentWeatherData: OfflineCurrentWeather = OfflineCurrentWeather()
    private let mockNetworkForecastWeatherData: GeoWeatherForecast
    private var mockForecastWeatherData: [WeeklyForecast] = []
    private var mockOfflineForecastWeatherData: [OfflineWeatherForecast]? = []
    private var mockForecastList: [WeatherForecast] = []
    
    init() {
        self.mockCurrentWeatherData = GeoWeather(coord: Coord(lon: 2.0, lat: 2.0),
                                                 weather: [Weather(main: "cloudy")],
                                                 main: Main(temp: 27.0, tempMin: 16, tempMax: 30),
                                                 name: "Johannesburg",
                                                 country: Country(name: "ZA"))
        let mockDateTime = 1351305
        let mockStartTemp = Double(20.0)
        for day in DaysOfTheWeek.allCases {
            
            self.mockForecastWeatherData.append(WeeklyForecast(dayOfWeek: day.rawValue,
                                                          temperature: mockStartTemp + 1.0,
                                                          weather: "rainy"))
            
            let offlineMock = OfflineWeatherForecast()
            offlineMock.weather = "rainy"
            offlineMock.temperature = mockStartTemp + 1.0
            offlineMock.dayOfWeek = day.rawValue
            self.mockOfflineForecastWeatherData?.append(offlineMock)
            
            self.mockForecastList.append(WeatherForecast(dt: mockDateTime+Int(1.0) ,
                                                         main: MainClass(temp: mockStartTemp+1.0),
                                                         weatherInfo: [WeatherInfo(info: "rainy")], dtTxt: String(describing: Date())))
        }
        self.mockNetworkForecastWeatherData = GeoWeatherForecast(forecastList: mockForecastList)
    }
    
    func fetchCurrentWeatherData(lat: Double, lon: Double, completion: @escaping (CurrentWeatherResponse)) {
        switch (testSuccess) {
        case true:
            return completion(.success(mockCurrentWeatherData))
        case false:
            return completion(.failure(ApiError.invalidResponse))
        }
    }
    
    func fetchForecastWeatherData(lat: Double, lon: Double, completion: @escaping (ForecastWeatherResponse)) {
        switch (testSuccess) {
        case true:
            return completion(.success(mockNetworkForecastWeatherData))
        case false:
            return completion(.failure(ApiError.invalidResponse))
        }
    }
    
    func saveLocation(context: NSManagedObjectContext, completion: @escaping ((Bool) -> Void)) {
        return completion(testSuccess)
    }
    
    func cacheCurrentWeather(context: NSManagedObjectContext, completion: @escaping ((Bool) -> Void)) {
        return completion(testSuccess)
    }
    
    func cacheCurrentForecast(context: NSManagedObjectContext, completion: @escaping ((Bool) -> Void)) {
        return completion(testSuccess)
    }
    
    func fetchCachedCurrentWeather(context: NSManagedObjectContext, completion: @escaping ((OfflineCurrentWeather?) -> Void)) {
        switch (testSuccess) {
        case true:
            return completion(mockOfflineCurrentWeatherData)
        case false:
            return completion(nil)
        }
    }
    
    func fetchCachedForecastWeather(context: NSManagedObjectContext, completion: @escaping (([OfflineWeatherForecast]?) -> Void)) {
        switch (testSuccess) {
        case true:
            return completion(mockOfflineForecastWeatherData)
        case false:
            return completion([])
        }
    }
    
}

class MockHomeDelegate: ViewModelDelegateType{
    func reloadView() {
    }
    
    
}
