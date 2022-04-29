//
//  OfflineCurrentWeather+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension OfflineCurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineCurrentWeather> {
        return NSFetchRequest<OfflineCurrentWeather>(entityName: "OfflineCurrentWeather")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastCache: String?
    @NSManaged public var offlineCoordinates: OfflineCurrentCoordinates?
    @NSManaged public var offlineWeather: OfflineWeather?
    @NSManaged public var offlineWeatherInfo: OfflineWeatherInfo?
    @NSManaged public var offlineCountry: OfflineCountry?

}

extension OfflineCurrentWeather : Identifiable {

}
