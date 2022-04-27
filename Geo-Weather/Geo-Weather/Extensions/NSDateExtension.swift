//
//  NSDateExtension.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import Foundation

extension NSDate {
    func day() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
}
