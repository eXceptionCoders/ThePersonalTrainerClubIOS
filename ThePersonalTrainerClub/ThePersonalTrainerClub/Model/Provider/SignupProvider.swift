//
//  SignupProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 10/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class SignupProvider {
    enum SignupError: Error {
        case userAlreadyExists
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func signup(model: SignupModel, completion: @escaping (Bool, Error?) -> Void) {
        webService.load(SignupResponse.self, from: Endpoint.signup(requestModel: SignupProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, SignupError.userAlreadyExists)
                default:
                    completion(false, SignupError.otherError)
                }
            } else {
                completion(true, nil)
            }
        }
    }
}

private class SignupProviderMapper {
    class func mapModelToEntity(model: SignupModel) -> SignupRequest {
        return SignupRequest(
            name: model.name,
            lastName: model.lastName,
            birthday: model.birthday,
            gender: model.gender,
            email: model.email,
            password: model.password
        )
    }
}
