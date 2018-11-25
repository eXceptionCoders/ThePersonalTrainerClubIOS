//
//  UserSettingsViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum UserSettingsContract {
    typealias View = UserSettingsView
    typealias Presenter = UserSettingsPresenter
    typealias Navigator = UserSettingsNavigator
}

protocol UserSettingsView: BaseContract.View {
}

protocol UserSettingsPresenter: BaseContract.Presenter {
    func onLogout()
}

protocol UserSettingsNavigator: BaseContract.Navigator {
    func navigateToLoginView()
}
