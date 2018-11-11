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
}
