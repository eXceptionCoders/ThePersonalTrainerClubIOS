//
//  SwitchModeViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class SwitchModeViewController: BaseViewController, SwitchModeContract.View {

    lazy var presenter: SwitchModeContract.Presenter = SwitchModeViewPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Switch"
    }

}
