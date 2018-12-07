//
//  ClassStripCell.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 30/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassStripCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var sportIcon: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var registeredLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var trainerLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var trainerTitleLabel: UILabel!
    
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
    
    var _imageLoaded = false;
    var imageLoaded: Bool {
        get { return _imageLoaded }
        set {
            _imageLoaded = true
        }
    }
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1.5
        marAsUnselected()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helpers
    
    private func markAsSelected() {
        self.layer.borderColor = UIColor.customOrange.cgColor
    }
    
    private func marAsUnselected() {
        self.layer.borderColor = UIColor.white.cgColor
    }

}
