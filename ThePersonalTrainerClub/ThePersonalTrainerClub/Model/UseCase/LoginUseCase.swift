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
    
    func login(model: LoginModel, completion: @escaping (UserModel?, Error?, [String: String]?) -> Void) {
        loginProvider.login(model: model) { success, error, errorsMap in
            if let error = error {
                completion(nil, error, errorsMap)
            } else {
                self.userProvider.fetchUser() { user, error, errorsMap in
                    if let error = error {
                        switch error {
                        case UserError.notFound:
                            completion(nil, LoginError.notFound, errorsMap)
                            break
                        default:
                            completion(nil, LoginError.otherError, errorsMap)
                            break
                        }
                    } else {
                        completion(user, error, errorsMap)
                    }
                }
            }
        }
    }
    
}
