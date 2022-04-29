//
//  OfflineWeatherInfo+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension OfflineWeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineWeatherInfo> {
        return NSFetchRequest<OfflineWeatherInfo>(entityName: "OfflineWeatherInfo")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var offlineCurrentWeather: OfflineCurrentWeather?

}

extension OfflineWeatherInfo : Identifiable {

}
