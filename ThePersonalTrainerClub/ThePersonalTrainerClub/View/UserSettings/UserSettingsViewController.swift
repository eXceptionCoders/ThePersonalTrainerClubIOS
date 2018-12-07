//
//  UserSettingsViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class UserSettingsViewController: BaseViewController, UserSettingsContract.View {

    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var logoutButton: DefaultButton!
    
    // MARK: - Presenter
    
    lazy var presenter: UserSettingsContract.Presenter = UserSettingsViewPresenter(view: self)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User settings"
        
        nameLabel.text = UserSettings.user?.name
        lastnameLabel.text = UserSettings.user?.lastName
    }
    
    // MARK: - Actions
    
    @IBAction func logout(_ sender: Any) {
        presenter.onLogout()
    }
}
