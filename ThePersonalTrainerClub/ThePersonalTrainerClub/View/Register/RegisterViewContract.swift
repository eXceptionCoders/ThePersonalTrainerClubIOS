//
//  RegisterViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum RegisterContract {
    typealias View = RegisterView
    typealias Presenter = RegisterPresenter
    typealias Navigator = RegisterNavigator
}

protocol RegisterView: BaseContract.View {
}

protocol RegisterPresenter: BaseContract.Presenter {
    func onRegister(name: String, lastName: String, gender: String, email: String, password: String)
}

protocol RegisterNavigator: BaseContract.Navigator {
    func navigateToLoginView()
    func navigateToMainView()
}
