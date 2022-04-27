//
//  ThemeProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation

protocol ThemeProviderType: AnyObject {
    var theme: Theme {get set}
    func changeTheme()
    func toggle(newTheme: Theme)
}

class ThemeProvider: ThemeProviderType {
    
    var theme: Theme
    
    init() {
        theme = .forest
    }
    
    func changeTheme() {
        if theme == .forest {
            toggle(newTheme: .sea)
        } else {
            toggle(newTheme: .forest)
        }
    }
    
    internal func toggle(newTheme: Theme) {
        theme = newTheme
    }
}
