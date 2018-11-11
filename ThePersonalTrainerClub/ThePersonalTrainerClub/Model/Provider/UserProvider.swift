//
//  UserProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class UserProvider {
    enum UserError: Error {
        case notFound
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchUser(_ userId: String, completion: @escaping (UserModel?, Error?) -> Void) {
        webService.load(UserResponse.self, from: Endpoint.userData(requestModel: UserRequest(id: userId))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.notFound:
                    completion(nil, UserError.notFound)
                default:
                    completion(nil, UserError.otherError)
                }
            } else if let response = responseObject {
                completion(UserProviderMapper.mapEntityToModel(response: response), nil)
            } else {
                completion(nil, UserError.otherError)
            }
        }
    }
}

private class UserProviderMapper {
    class func mapEntityToModel(response: UserResponse) -> UserModel {
        return UserModel(
            id: response.data._id,
            name: response.data.name,
            lastName: response.data.lastName,
            birthday: response.data.birthday,
            gender: response.data.gender,
            thumbnail: response.data.thumbnail,
            email: response.data.email,
            locations: [],
            activities: [],
            description: response.data.description
        )
    }
}
