//
//  UserSettingsViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class UserSettingsViewNavigator: UserSettingsContract.Navigator {
    private var view: UserSettingsContract.View
    
    init(view: UserSettingsContract.View) {
        self.view = view
    }
    
    func navigateToLoginView() {
        (UIApplication.shared.delegate as! AppDelegate).switchToLoginViewController()
    }
}
