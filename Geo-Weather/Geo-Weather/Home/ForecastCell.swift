//
//  ForecastCell.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/27.
//

import Foundation
import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet private weak var day: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var temperature: UILabel!
    
    func setUpCell(for forecast: WeeklyForecast) {
        day.text = forecast.dayOfWeek
        temperature.text = String(format: "%.1f", forecast.temperature) + "°"
    }
}
