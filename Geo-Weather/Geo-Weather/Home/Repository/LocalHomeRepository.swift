//
//  SaveLocationRepository.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation
import CoreData

protocol LocalHomeRepositoryType: AnyObject {
    func saveLocation(location: NSManagedObject,completion: @escaping((Bool) -> Void))
}

class LocalHomeRepository: LocalHomeRepositoryType {
    func saveLocation(location: NSManagedObject,completion: @escaping ((Bool) -> Void)) {
        do {
          
            try PersistanceContext.shared?.save()
        } catch {
            completion(false)
        }
    }
}
