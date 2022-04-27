//
//  ViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var themeToggler: UISegmentedControl!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherOutlook: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    private lazy var homeViewModel = HomeViewModel(delegate: self,
                                                   repository: HomeRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeToggler.addBorder()
        homeViewModel.fetchCurrentWeather()
    }
    
    @IBAction private func themeToggle(_ sender: Any) {
        homeViewModel.changeTheme()
        homeViewModel.fetchCurrentWeather()
    }
    
    private func loadWeatherImage() {
        guard let imageName = homeViewModel.weatherImage else {
            weatherImage.image = UIImage()
            weatherImage.backgroundColor = .rainy
            return
        }
        weatherImage.image = UIImage(named: imageName )
    }
    
    private func loadWeatherinfo() {
        guard let temp = homeViewModel.temperature,
              let outlook = homeViewModel.outLook else {
            return
        }
        temperature.text = temp
        weatherOutlook.text = outlook
    }

    private func setBackground() {
        guard let weather = homeViewModel.outLook,
              let weatherType = WeatherType(rawValue: weather.lowercased()) else {
            self.view.backgroundColor = .cloudy
            return
        }
        switch (weatherType) {
        case .clouds:
            self.view.backgroundColor = .cloudy
        case .rainy:
            self.view.backgroundColor = .rainy
        case .sunny:
            self.view.backgroundColor = .sunny
        }

    }
}

extension HomeViewController: ViewModelDelegateType {
    func reloadView() {
        DispatchQueue.main.async {
            self.loadWeatherImage()
            self.loadWeatherinfo()
            self.setBackground()
        }
    }
    
    func alert() {
        
    }
}
