//
//  SignupUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class RegisterUseCase {
    
    private var registerProvider: RegisterProvider
    
    init(registerProvider: RegisterProvider) {
        self.registerProvider = registerProvider
    }
    
    func signup(model: RegisterModel, completion: @escaping (Bool?, Error?, [String: String]?) -> Void) {
        registerProvider.signup(model: model, completion: completion)
    }
    
}
