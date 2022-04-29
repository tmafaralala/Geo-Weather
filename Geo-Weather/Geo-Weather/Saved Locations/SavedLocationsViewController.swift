//
//  SavedLocationsViewController.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import UIKit

class SavedLocationsViewController: UIViewController {

    @IBOutlet weak var savedLocations: UITableView!
    
    private lazy var savedLocationsViewModel = SavedLocationsViewModel(delegate: self,
                                                                       repository: SavedLocationsReposirtory())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedLocations.delegate = self
        savedLocations.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = .red
        DispatchQueue.main.async {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                return
            }
            self.savedLocationsViewModel.fetchSavedLocations(context: context)
        }
    }
    
}

extension SavedLocationsViewController: ViewModelDelegateType {
    func reloadView() {
        DispatchQueue.main.async {
            self.savedLocations.reloadData()
        }
    }
}

extension  SavedLocationsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedLocationsViewModel.locations
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let locationCell = savedLocations.dequeueReusableCell(withIdentifier: "LocationCell") as? SavedLocationTableViewCell else {
            return UITableViewCell()
        }
        locationCell.setUpCell(for: savedLocationsViewModel.location(at: indexPath.item))
        return locationCell
    }
}
