//
//  ViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet private weak var themeToggler: UISegmentedControl!
    @IBOutlet private weak var currentTemp: UILabel!
    @IBOutlet private weak var minimumTemp: UILabel!
    @IBOutlet private weak var maximumTemp: UILabel!
    @IBOutlet private weak var forecast: UITableView!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var locationName: UILabel!
    @IBOutlet private weak var weatherOutlook: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
    
    private lazy var homeViewModel = HomeViewModel(delegate: self,
                                                   networkRepository: HomeRepository(),
                                                   localRepository: LocalHomeRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forecast.delegate = self
        self.forecast.dataSource = self
        self.forecast.layer.backgroundColor = UIColor.clear.cgColor
        self.forecast.backgroundColor = .clear
        self.forecast.backgroundColor = .clear
        themeToggler.addBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = .white
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
        locationName.text = homeViewModel.locationName
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
        case .rainy, .rain:
            self.view.backgroundColor = .rainy
        case .sunny, .clear:
            self.view.backgroundColor = .sunny
        }

    }
    @IBAction private func saveLocation(_ sender: Any) {
        let alertController = UIAlertController(title: "Location nickname.",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.textFields?[0].placeholder = "example: Home"
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let location = alertController.textFields?[0].text else {
                return
            }
            self.homeViewModel.saveLocation(named: location )
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
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
    
    func loading() {

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
