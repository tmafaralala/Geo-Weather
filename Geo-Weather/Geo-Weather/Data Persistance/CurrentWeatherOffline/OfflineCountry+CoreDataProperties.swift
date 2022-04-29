//
//  OfflineCountry+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension OfflineCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineCountry> {
        return NSFetchRequest<OfflineCountry>(entityName: "OfflineCountry")
    }

    @NSManaged public var name: String?
    @NSManaged public var offlineCurrentWeather: OfflineCurrentWeather?

}

extension OfflineCountry : Identifiable {

}
