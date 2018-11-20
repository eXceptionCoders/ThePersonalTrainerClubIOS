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
            view.showAlertMessage(title: NSLocalizedString("login_error_title", comment: ""), message: NSLocalizedString("login_error_empty_field", comment: ""))
            return
        }
        
        let loginModel = LoginModel(email: email, password: password)
        loginUseCase.login(model: loginModel) { loggedIn, error in
            if let error = error {
                var message = ""
                switch error {
                case LoginError.userPasswordNotFound:
                    message = NSLocalizedString("login_error_wrong_user", comment: "")
                case LoginError.incorrectEntry:
                    message = NSLocalizedString("login_error_invalid_email", comment: "")
                case LoginError.otherError:
                    message = NSLocalizedString("login_error_default", comment: "")
                default:
                    message = ""
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.navigator.navigateToMainView()
            }
            
            self.view.hideLoading()
        }
    }
    
    func onRegister() {
        navigator.navigateToRegisterView()
    }
}
