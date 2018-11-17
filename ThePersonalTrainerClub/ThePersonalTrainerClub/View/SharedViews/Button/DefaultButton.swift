//
//  DefaultButton.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 13/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.customOrange.cgColor
        
        self.setTitleColor(UIColor.customOrange, for: .normal)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}
