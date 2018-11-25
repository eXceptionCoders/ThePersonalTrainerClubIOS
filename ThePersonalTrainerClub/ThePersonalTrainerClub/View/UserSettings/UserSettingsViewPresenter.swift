//
//  UserSettingsViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class UserSettingsViewPresenter: BaseViewPresenter, UserSettingsContract.Presenter {
    private var view: UserSettingsContract.View
    private lazy var navigator: UserSettingsContract.Navigator = UserSettingsViewNavigator(view: view)
    
    init(view: UserSettingsContract.View) {
        self.view = view
    }
    
    func onLogout() {
        UserSettings.token = ""
        UserSettings.user = nil
        navigator.navigateToLoginView()
    }
}
