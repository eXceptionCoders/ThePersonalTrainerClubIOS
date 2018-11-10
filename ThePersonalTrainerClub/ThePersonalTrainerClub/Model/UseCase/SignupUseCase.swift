//
//  SignupUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class SignupUseCase {
    
    private var signupProvider: SignupProvider
    
    init(signupProvider: SignupProvider) {
        self.signupProvider = signupProvider
    }
    
    func signup(model: SignupModel, completion: @escaping (Bool?, Error?) -> Void) {
        signupProvider.signup(model: model, completion: completion)
    }
    
}
