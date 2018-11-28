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
    
    func onRegister(name: String, lastName: String, gender: String, email: String, password: String, coach: Bool) {
        if (name.isEmpty || lastName.isEmpty || gender.isEmpty || email.isEmpty || password.isEmpty) {
            self.view.showAlertMessage(title: nil, message: NSLocalizedString("register_error_empty_field", comment: ""))
            return
        }

        view.showLoading()
        
        let model = RegisterModel(
            name: name,
            lastName: lastName,
            birthday: "1900-1-1",
            gender: gender,
            email: email,
            password: password,
            coach: coach)
        
        registerUseCase.signup(model: model) { (signed, error, errorsMap) in
            self.view.hideLoading()

            if let error = error {
                
                var message = ""
                switch error {
                case RegisterError.unprocessableEntity:
                    message = NSLocalizedString("register_server_error", comment: "")
                case LoginError.otherError:
                    message = NSLocalizedString("register_server_error", comment: "")
                default:
                    message = ""
                }
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.navigator.navigateToLoginView()
            }
        }
    }
}
