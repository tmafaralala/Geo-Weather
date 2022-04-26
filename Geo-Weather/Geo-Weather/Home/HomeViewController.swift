//
//  ViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var themeToggler: UISegmentedControl!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    private lazy var homeViewModel = HomeViewModel(delegate: self,
                                                   repository: HomeRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeToggler.addBorder()
        weatherImage.image = homeViewModel.weatherImage
        homeViewModel.fetchCurrentWeather()
    }
    
    @IBAction private func themeToggle(_ sender: Any) {
        homeViewModel.changeTheme()
        reloadView()
    }

}

extension HomeViewController: ViewModelDelegateType {
    func reloadView() {
        DispatchQueue.main.async {
            self.weatherImage.image = self.homeViewModel.weatherImage
        }
    }
    
    func alert() {
        
    }
}
