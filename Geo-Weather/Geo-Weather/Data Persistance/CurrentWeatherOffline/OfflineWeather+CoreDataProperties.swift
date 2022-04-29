//
//  OfflineWeather+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension OfflineWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineWeather> {
        return NSFetchRequest<OfflineWeather>(entityName: "OfflineWeather")
    }

    @NSManaged public var name: String?
    @NSManaged public var offlineCurrentWeather: OfflineCurrentWeather?

}

extension OfflineWeather : Identifiable {

}
