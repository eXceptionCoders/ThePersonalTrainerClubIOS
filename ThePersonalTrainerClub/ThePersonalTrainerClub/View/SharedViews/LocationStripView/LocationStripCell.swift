//
//  LocationStripCell.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 18/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class LocationStripCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    
    var allowSelection: Bool = true
    
    override var isSelected: Bool {
        get { return super.isSelected }
        set {
            super.isSelected = newValue;
            
            if (newValue) {
                markAsSelected()
            } else {
                marAsUnselected()
            }
        }
    }
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()

        locationLabel.layer.cornerRadius = 14.0
        locationLabel.clipsToBounds = true
        locationLabel.layer.borderWidth = 1.0
        locationImage.tintColor = UIColor.customOrange
        
        marAsUnselected()
    }

    private func markAsSelected() {
        if allowSelection {
            self.locationLabel.layer.borderColor = UIColor.customOrange.cgColor
        }
    }
    
    private func marAsUnselected() {
        if allowSelection {
            self.locationLabel.layer.borderColor = UIColor.white.cgColor
        }
    }
}
