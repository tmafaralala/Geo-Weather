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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeToggler.addBorder()
        weatherImage.image = ImageProvider.instance.cloudy
    }
    
    @IBAction private func themeToggle(_ sender: Any) {
        ThemeProvider.instance.changeTheme()
        reloadView()
    }

}

extension HomeViewController: ViewModelDelegateType {
    func reloadView() {
        weatherImage.image = ImageProvider.instance.cloudy
    }
    
    func alert() {
        
    }
}
