//
//  FavouriteLocation+CoreDataProperties.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//
//

import Foundation
import CoreData

extension FavouriteLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteLocation> {
        return NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
    }

    @NSManaged public var lat: Double
    @NSManaged public var location: String?
    @NSManaged public var lon: Double
    @NSManaged public var name: String?

}

extension FavouriteLocation : Identifiable {

}
