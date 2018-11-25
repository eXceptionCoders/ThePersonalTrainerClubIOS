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
    private var userProvider: UserProvider
    
    init(loginProvider: LoginProvider, userProvider: UserProvider) {
        self.loginProvider = loginProvider
        self.userProvider = userProvider
    }
    
    func login(model: LoginModel, completion: @escaping (UserModel?, Error?) -> Void) {
        loginProvider.login(model: model) { success, error in
            if let error = error {
                completion(nil, error)
            } else {
                self.userProvider.fetchUser() { user, error in
                    if let error = error {
                        switch error {
                        case UserError.notFound:
                            completion(nil, LoginError.notFound)
                            break
                        default:
                            completion(nil, LoginError.otherError)
                            break
                        }
                    } else {
                        completion(user, error)
                    }
                }
            }
        }
    }
    
}
