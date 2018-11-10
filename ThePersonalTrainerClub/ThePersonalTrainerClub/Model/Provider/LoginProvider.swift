//
//  LoginProvider.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class LoginProvider {
    enum LoginError: Error {
        case userPasswordNotFound
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func login(model: LoginModel, completion: @escaping (Bool, Error?) -> Void) {
        webService.load(LoginResponse.self, from: Endpoint.login(requestModel: LoginProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.forbiddenError:
                    completion(false, LoginError.userPasswordNotFound)
                default:
                    completion(false, LoginError.otherError)
                }
            } else {
                completion(true, nil)
            }
        }
    }
}

private class LoginProviderMapper {
    class func mapModelToEntity(model: LoginModel) -> LoginRequest {
        return LoginRequest(email: model.email,
                            password: model.password)
    }
}
