//
//  UserSettingsViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

enum UserSettingsContract {
    typealias View = UserSettingsView
    typealias Presenter = UserSettingsPresenter
    typealias Navigator = UserSettingsNavigator
}

protocol UserSettingsView: BaseContract.View {
    func setUser(_ user: UserModel)
}

protocol UserSettingsPresenter: BaseContract.Presenter {
    func setThumbnail(_ image: UIImage)
    func onLogout()
    func fetchUser()
}

protocol UserSettingsNavigator: BaseContract.Navigator {
    func navigateToLoginView()
}
