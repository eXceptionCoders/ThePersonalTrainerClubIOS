//
//  LoginProvider.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case notFound
    case userPasswordNotFound
    case incorrectEntry
    case otherError
}

class LoginProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func login(model: LoginModel, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(LoginResponse.self, from: Endpoint.login(requestModel: LoginProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unauthorized:
                    completion(false, LoginError.userPasswordNotFound, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, LoginError.incorrectEntry, responseObject?.error)
                default:
                    completion(false, LoginError.otherError, responseObject?.error)
                }
            } else if let response = responseObject, let data = response.data {
                LoginProviderMapper.mapEntityToModel(data: data)
                completion(true, nil, nil)
            } else {
                completion(false, LoginError.otherError, responseObject?.error)
            }
        }
    }
}

private class LoginProviderMapper {
    class func mapModelToEntity(model: LoginModel) -> LoginRequest {
        return LoginRequest(email: model.email,
                            password: model.password)
    }
    
    class func mapEntityToModel(data: LoginEntity) {
        UserSettings.token = data.token
    }
}
