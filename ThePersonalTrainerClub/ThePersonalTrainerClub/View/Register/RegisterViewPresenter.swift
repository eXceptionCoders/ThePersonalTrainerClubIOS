//
//  RegisterViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class RegisterViewPresenter: BaseViewPresenter, RegisterContract.Presenter {

    private var view: RegisterContract.View
    private var registerUseCase: RegisterUseCase
    private lazy var navigator: RegisterContract.Navigator = RegisterViewNavigator(view: view)
    
    init(view: RegisterContract.View, registerUseCase: RegisterUseCase) {
        self.view = view
        self.registerUseCase = registerUseCase
    }
    
    func onRegister(name: String, lastName: String, gender: String, email: String, password: String) {
        view.showLoading()
        
        if (name.isEmpty || lastName.isEmpty || gender.isEmpty || email.isEmpty || password.isEmpty) {
            self.view.showAlertMessage(title: nil, message: NSLocalizedString("register_error_empty_field", comment: ""))
            return
        }
        
        let model = RegisterModel(name: name, lastName: lastName, birthday: "1900-1-1", gender: gender, email: email, password: password)
        
        registerUseCase.signup(model: model) { (signed, error) in
            if let error = error {
                var message = ""
                switch error {
                case RegisterError.userAlreadyExists:
                    message = NSLocalizedString("register_error_user_exists", comment: "")
                case LoginError.otherError:
                    message = NSLocalizedString("register_error_default", comment: "")
                default:
                    message = ""
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.navigator.navigateToLoginView()
            }
        }
    }
}
