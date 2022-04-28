//
//  SavedLocationTableViewCell.swift
//  Geo-Weather
//
//  Created by Tshwarelo Mafaralala on 2022/04/28.
//

import UIKit

class SavedLocationTableViewCell: UITableViewCell {

    @IBOutlet private weak var locationName: UILabel!
    @IBOutlet private weak var location: UILabel!
    
    func setUpCell(for location: FavouriteLocation?) {
        locationName.text = location?.name
        guard let cellLocation = location?.location else {
            return
        }
        locationSetup(location: cellLocation)
    }
    
    private func locationSetup(location: String) {
        let icon = NSTextAttachment()
        icon.image = UIImage(systemName:"mappin.and.ellipse")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        
        let imageOffsetY: CGFloat = -5.0
        icon.bounds = CGRect(x: 0, y: imageOffsetY, width: icon.image!.size.width+5, height: icon.image!.size.height+5)
        let iconString = NSAttributedString(attachment: icon)
        let locationAttr = NSAttributedString(string: location)
        let text = NSMutableAttributedString(string: "")
        text.append(iconString)
        text.append(locationAttr)
        self.location.textAlignment = .center
        self.location.attributedText = text
    }
}
