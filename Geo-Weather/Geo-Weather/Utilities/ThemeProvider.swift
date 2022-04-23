//
//  ThemeProvider.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/23.
//

import Foundation

class ThemeProvider {
    private var currentTheme: Theme = .forest
    
    var theme: Theme {
        return currentTheme
    }
    
    func changeTheme() {
        if currentTheme == .forest {
            toggle(newTheme: .sea)
        }
        else{
            toggle(newTheme: .forest)
        }
    }
    
    func toggle(newTheme: Theme){
        currentTheme = newTheme
    }
}
