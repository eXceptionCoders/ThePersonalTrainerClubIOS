//
//  UIViewControllerExtension.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

enum RightButtonType : String {
    case RightButtonTypeLocation = "Location"
    case RightButtonTypeSport = "AddSelected"
}

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
    
    func addRightButtons(_ buttonsType: [RightButtonType], action: Selector) {
        for buttonType in buttonsType {
            let button = self.buttonForType(buttonType)
            button.tag = buttonType.hashValue
            button.addTarget(self, action: action, for: .touchUpInside)
            let buttonContainer = UIView(frame: button.frame)
            buttonContainer.addSubview(button)
            let buttonItem = UIBarButtonItem(customView: buttonContainer)
            if let rightButtons = navigationItem.rightBarButtonItems, rightButtons.count > 0 {
                navigationItem.rightBarButtonItems!.append(buttonItem)
            } else {
                navigationItem.rightBarButtonItem = buttonItem
            }
        }
    }
    
    private func buttonForType<T: RawRepresentable>(_ type: T) -> UIButton where T.RawValue == String {
        let image = UIImage(named: type.rawValue)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(image, for: UIControl.State.normal)
        button.tintColor = UIColor.white
        button.transform = CGAffineTransform(translationX: 5, y: 0)
        
        return button
    }
}
