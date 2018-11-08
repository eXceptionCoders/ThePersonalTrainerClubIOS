//
//  UIViewControllerExtension.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

extension UIViewController {
    func embedInNavigationController() -> UINavigationController{
        return UINavigationController(rootViewController: self)
    }
    
    func setupNavigationBarColor() {
        navigationController?.navigationBar.barTintColor = UIColor.customOrange
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupNavigationBarTitle() {
        let myType = type(of: self)
        self.title = String(describing: myType)
    }
    
    func setupNavigationBarTitle(_ title: String) {
        self.title = title
    }
}
