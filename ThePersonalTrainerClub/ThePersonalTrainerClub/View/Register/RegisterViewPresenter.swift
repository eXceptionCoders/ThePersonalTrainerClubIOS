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
            self.view.showAlertMessage(title: nil, message: "Please fill all required fields")
            return
        }
        
        let model = RegisterModel(name: name, lastName: lastName, birthday: "1900-1-1", gender: gender, email: email, password: password)
        
        registerUseCase.signup(model: model) { (signed, error) in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else {
                self.navigator.navigateToLoginView()
            }
        }
    }
}
