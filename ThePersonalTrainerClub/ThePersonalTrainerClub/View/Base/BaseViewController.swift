//
//  BaseViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController, BaseContract.View {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarColor()
        setupNavigationBarTitle()
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
