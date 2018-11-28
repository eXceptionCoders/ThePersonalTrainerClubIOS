//
//  RegisterProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum RegisterError: Error {
    case unprocessableEntity
    case otherError
}

class RegisterProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func signup(model: RegisterModel, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(SignupResponse.self, from: Endpoint.register(requestModel: RegisterProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, RegisterError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, RegisterError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}

private class RegisterProviderMapper {
    class func mapModelToEntity(model: RegisterModel) -> RegisterRequest {
        return RegisterRequest(
            name: model.name,
            lastName: model.lastName,
            birthday: model.birthday,
            gender: model.gender,
            email: model.email,
            password: model.password,
            coach: model.coach
        )
    }
}
