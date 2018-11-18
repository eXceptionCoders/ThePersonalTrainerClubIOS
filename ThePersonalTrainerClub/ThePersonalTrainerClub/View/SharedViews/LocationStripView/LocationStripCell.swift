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
        marAsUnselected()
    }

    private func markAsSelected() {
        self.locationLabel.layer.borderColor = UIColor.customOrange.cgColor
    }
    
    private func marAsUnselected() {
        self.locationLabel.layer.borderColor = UIColor.white.cgColor
    }
}
