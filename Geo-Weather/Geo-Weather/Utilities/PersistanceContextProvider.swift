//
//  PersistanceContextProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation
import UIKit
import CoreData

class PersistanceContext {
    static let shared = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private init() {
        
    }
}
