//
//  ViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var themeToggler: UISegmentedControl!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var minimumTemp: UILabel!
    @IBOutlet weak var maximumTemp: UILabel!
    @IBOutlet weak var forecast: UITableView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var weatherOutlook: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    private lazy var homeViewModel = HomeViewModel(delegate: self,
                                                   repository: HomeRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forecast.delegate = self
        self.forecast.dataSource = self
        self.forecast.layer.backgroundColor = UIColor.clear.cgColor
        self.forecast.backgroundColor = .clear
        self.forecast.backgroundColor = .clear
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
            return
        }
        weatherImage.image = UIImage(named: imageName )
    }
    
    private func loadWeatherinfo() {
        guard let temp = homeViewModel.currTemp,
              let minTemp = homeViewModel.minTemp,
              let maxTemp = homeViewModel.maxTemp,
              let outlook = homeViewModel.outLook else {
            return
        }
        temperature.text = temp
        currentTemp.text = temp
        minimumTemp.text = minTemp
        maximumTemp.text = maxTemp
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
        case .sunny, .clear:
            self.view.backgroundColor = .sunny
        }

    }
    @IBAction func saveLocation(_ sender: Any) {
    }
}

extension HomeViewController: ViewModelDelegateType {
    func reloadView() {
        DispatchQueue.main.async {
            self.loadWeatherImage()
            self.loadWeatherinfo()
            self.setBackground()
            self.forecast.reloadData()
        }
    }
    
    func alert() {
        
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.forecastCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let forecastCell = forecast.dequeueReusableCell(withIdentifier: "DayForecast")
                as? ForecastCell,
              let forecast = homeViewModel.foreCast(at: indexPath.item) else {
            return UITableViewCell()
        }
        forecastCell.setUpCell(for: forecast)
        forecastCell.backgroundColor = .clear
        return forecastCell
    }
}
