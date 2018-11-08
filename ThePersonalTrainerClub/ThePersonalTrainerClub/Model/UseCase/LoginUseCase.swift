//
//  LoginUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class LoginUseCase {
    
    private var loginProvider: LoginProvider
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
    }
    
    func login(model: LoginModel, completion: @escaping (Bool?, Error?) -> Void) {
        loginProvider.login(model: model, completion: completion)
    }
    
}
