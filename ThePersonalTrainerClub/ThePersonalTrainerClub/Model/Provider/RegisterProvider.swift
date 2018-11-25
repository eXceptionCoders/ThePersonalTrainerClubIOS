//
//  RegisterProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum RegisterError: Error {
    case userAlreadyExists
    case otherError
}

class RegisterProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func signup(model: RegisterModel, completion: @escaping (Bool, Error?) -> Void) {
        webService.load(SignupResponse.self, from: Endpoint.register(requestModel: RegisterProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, RegisterError.userAlreadyExists)
                default:
                    completion(false, RegisterError.otherError)
                }
            } else {
                completion(true, nil)
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
