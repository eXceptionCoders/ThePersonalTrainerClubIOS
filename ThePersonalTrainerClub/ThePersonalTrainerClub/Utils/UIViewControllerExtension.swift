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
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
    }
    
    func setupTabBarColor() {}
        
    func setupNavigationBarTitle() {
        let myType = type(of: self)
        self.title = String(describing: myType)
    }
    
    func setupNavigationBarTitle(_ title: String) {
        self.title = title
    }
    
    func showMessage(_ message: String) {
        let alertVC = UIAlertController(title: "MENSAJE!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Vale", style: .default) { _ in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}
