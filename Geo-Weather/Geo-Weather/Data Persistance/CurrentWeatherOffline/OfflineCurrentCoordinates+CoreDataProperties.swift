//
//  OfflineCurrentCoordinates+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension OfflineCurrentCoordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineCurrentCoordinates> {
        return NSFetchRequest<OfflineCurrentCoordinates>(entityName: "OfflineCurrentCoordinates")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var offlineCurrentWeather: OfflineCurrentWeather?

}

extension OfflineCurrentCoordinates : Identifiable {

}
