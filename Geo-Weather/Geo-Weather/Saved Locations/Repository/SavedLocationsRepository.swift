//
//  SaveLocationsRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation
import CoreData

protocol SavedLocationsRepositoryType: AnyObject {
    func fetchSavedLocations(context: NSManagedObjectContext,
                             completion: @escaping(([FavouriteLocation]?) -> Void))
}

class SavedLocationsReposirtory: SavedLocationsRepositoryType {
    func fetchSavedLocations(context: NSManagedObjectContext,
                             completion: @escaping (([FavouriteLocation]?) -> Void)) {
        do {
            completion(try context.fetch(FavouriteLocation.fetchRequest()))
        } catch {
            completion([])
        }
    }
}
