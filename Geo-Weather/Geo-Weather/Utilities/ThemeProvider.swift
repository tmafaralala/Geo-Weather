//
//  ThemeProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation

class ThemeProvider {
    static let instance = ThemeProvider()
    private var currentTheme: Theme!
    
    var theme: Theme {
        return currentTheme
    }
    
    private init() {
        currentTheme = .forest
    }
    
    func changeTheme() {
        if currentTheme == .forest {
            toggle(newTheme: .sea)
        } else {
            toggle(newTheme: .forest)
        }
    }
    
    func toggle(newTheme: Theme) {
        currentTheme = newTheme
    }
}
