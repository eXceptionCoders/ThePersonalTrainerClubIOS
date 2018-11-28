//
//  UIViewExtension.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 28/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

extension UIView {
    func setRoundedBorder() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.customOrange.cgColor
    }
}
