//
//  UIImageViewExtension.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 08/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setupAsUserThumbnail() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.customOrange.cgColor
    }
}
