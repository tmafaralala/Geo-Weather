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
        guard let weather = WeatherType(rawValue: forecast.weather.lowercased()) else {
            return
        }
        icon.image = cellIcon(for: weather)
        temperature.text = String(format: "%.1f", forecast.temperature) + "°"
    }
    
    private func cellIcon(for forecastWeather: WeatherType) -> UIImage {
        switch (forecastWeather) {
        case .clouds:
            guard let image = UIImage(named: "clouds") else {
                return UIImage()
            }
            return image
        case .sunny, .clear:
            guard let image = UIImage(named: "sunny") else {
                return UIImage()
            }
            return image
        case .rainy, .rain:
            guard let image = UIImage(named: "rainy") else {
                return UIImage()
            }
            return image
        }
    }
}
