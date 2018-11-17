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
            view.showAlertMessage(title: "Error", message: "Debes rellenar todos los campos")
            return
        }
        
        let loginModel = LoginModel(email: email, password: password)
        loginUseCase.login(model: loginModel) { loggedIn, error in
            if let error = error {
                var message = ""
                switch error {
                case LoginError.userPasswordNotFound:
                    message = "Usuario no encontrado o password incorrecto"
                case LoginError.incorrectEntry:
                    message = "El email está mal escrito"
                case LoginError.otherError:
                    message = "Ha ocurrido un error durante el login"
                default:
                    message = ""
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.view.showAlertMessage(title: nil, message: "OK")
            }
            
            self.view.hideLoading()
        }
    }
    
    func onRegister() {
        navigator.navigateToRegisterView()
    }
}
