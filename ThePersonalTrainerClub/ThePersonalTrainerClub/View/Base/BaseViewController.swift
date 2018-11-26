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
        localizeView()
    }
    
    func showAlertMessage(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func localizeView() {}
    
    func showLoading() {}
    func hideLoading() {}
}
