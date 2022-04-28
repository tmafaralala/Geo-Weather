//
//  SavedLocationsViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation

class SavedLocationsViewModel {
    private weak var delegate: ViewModelDelegateType?
    private var repository: SavedLocationsRepositoryType?
    private var savedLocations: [FavouriteLocation]!
    
    init(delegate: ViewModelDelegateType,
         repository:SavedLocationsRepositoryType) {
        self.delegate = delegate
        self.repository = repository
        self.savedLocations = []
    }
    
    var locations: Int {
        savedLocations.count
    }
    
    func location(at index: Int) -> FavouriteLocation? {
        return savedLocations[index]
    }
    
    func fetchSavedLocations() {
        repository?.fetchSavedLocations() { [weak self] locations in
            self?.savedLocations = locations
            self?.delegate?.reloadView()
        }
    }
}
