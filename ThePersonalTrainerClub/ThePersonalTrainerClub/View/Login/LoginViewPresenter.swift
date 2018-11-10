//
//  LoginViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class LoginViewPresenter: BaseViewPresenter, LoginContract.Presenter {
    private var view: LoginContract.View
    private var loginUseCase: LoginUseCase
    private lazy var navigator: LoginContract.Navigator = LoginViewNavigator(view: view)
    
    init(view: LoginContract.View, loginUseCase: LoginUseCase) {
        self.view = view
        self.loginUseCase = loginUseCase
    }
    
    func onLogin(email: String, password: String) {
        view.showLoading()
        
        if (email.isEmpty || password.isEmpty) {
            return
        }
        
        let loginModel = LoginModel(email: email, password: password)
        loginUseCase.login(model: loginModel) { loggedIn, error in
            if let error = error {
                self.view.showMessage("\(error)")
            } else {
                self.view.showMessage("OK")
            }
            
            self.view.hideLoading()
        }
    }
    
    func onRegister() {
        navigator.navigateToRegisterView()
    }
}
