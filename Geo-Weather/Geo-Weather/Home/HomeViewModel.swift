//
//  HomeViewModel.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import Foundation

class HomeViewModel {
    private var repository: HomeRepositoryType?
    private weak var delegate: ViewModelDelegateType?
    
    init(delegate: ViewModelDelegateType, repository: HomeRepositoryType) {
        self.repository = repository
        self.delegate = delegate
    }
}
