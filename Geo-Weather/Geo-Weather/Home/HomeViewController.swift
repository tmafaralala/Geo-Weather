//
//  ViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import UIKit
import CoreData
import CoreLocation

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
    @IBOutlet private weak var updateTime: UILabel!
    private let locationManager: CLLocationManager = CLLocationManager()
    
    private lazy var homeViewModel = HomeViewModel(delegate: self,
                                                   repository: HomeRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forecast.delegate = self
        self.forecast.dataSource = self
        setUpDesign()
        setUpLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = .white
        DispatchQueue.main.async {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                  let lat = self.locationManager.location?.coordinate.latitude,
                  let lon = self.locationManager.location?.coordinate.longitude else {
                return
            }
            self.homeViewModel.fetchWeather(context:context, lon: lon, lat: lat )
        }
    }
    
    private func setUpLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setUpDesign() {
        self.forecast.layer.backgroundColor = UIColor.clear.cgColor
        self.forecast.backgroundColor = .clear
        self.forecast.backgroundColor = .clear
        themeToggler.addBorder()
    }
    
    @IBAction private func themeToggle(_ sender: Any) {
        homeViewModel.changeTheme()
        DispatchQueue.main.async {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                  let lat = self.locationManager.location?.coordinate.latitude,
                  let lon = self.locationManager.location?.coordinate.longitude else {
                return
            }
            self.homeViewModel.fetchWeather(context:context, lon: lon, lat: lat )
        }
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
        updateTime.text = "Last Update: "+homeViewModel.updateTime
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
            DispatchQueue.main.async {
                guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                    return
                }
                self.homeViewModel.saveLocation(context: context,named: location )
            }
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

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                  let lat = self.locationManager.location?.coordinate.latitude,
                  let lon = self.locationManager.location?.coordinate.longitude else {
                return
            }
            self.homeViewModel.fetchWeather(context:context, lon: lon, lat: lat )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
}
