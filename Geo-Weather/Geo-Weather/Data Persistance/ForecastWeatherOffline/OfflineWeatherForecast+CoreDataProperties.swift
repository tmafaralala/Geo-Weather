//
//  OfflineWeatherForecast+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/29.
//
//

import Foundation
import CoreData

extension OfflineWeatherForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineWeatherForecast> {
        return NSFetchRequest<OfflineWeatherForecast>(entityName: "OfflineWeatherForecast")
    }

    @NSManaged public var dayOfWeek: String?
    @NSManaged public var temperature: Double
    @NSManaged public var weather: String?

}

extension OfflineWeatherForecast : Identifiable {

}
