//
//  LoginViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum LoginContract {
    typealias View = LoginView
    typealias Presenter = LoginPresenter
    typealias Navigator = LoginNavigator
}

protocol LoginView: BaseContract.View {
    func showMessage(_: String)
}

protocol LoginPresenter: BaseContract.Presenter {
    func onLogin(email: String, password: String)
    func onRegister()
}

protocol LoginNavigator: BaseContract.Navigator {
    func navigateToRegisterView()
    func navigateToMainView()
}
