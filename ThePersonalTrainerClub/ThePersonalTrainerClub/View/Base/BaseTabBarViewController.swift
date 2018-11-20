//
//  BaseTabBarViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarViewController: UITabBarController, BaseContract.View {
    func localizeView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupNavigationBarColor()
        tabBar.barTintColor = UIColor.customOrange
        setupNavigationBarTitle()
    }
    
}
