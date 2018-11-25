//
//  UserProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum UserError: Error {
    case notFound
    case otherError
}

class UserProvider {    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void) {
        webService.load(UserResponse.self, from: Endpoint.userData(requestModel: UserRequest())) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.notFound:
                    completion(nil, UserError.notFound)
                default:
                    completion(nil, UserError.otherError)
                }
                
                UserSettings.token = ""
            } else if let response = responseObject, let data = response.data {
                completion(UserProviderMapper.mapEntityToModel(data: data), nil)
            } else {
                completion(nil, UserError.otherError)
                UserSettings.token = ""
            }
        }
    }
}

private class UserProviderMapper {
    class func mapEntityToModel(data: UserEntity) -> UserModel {
        let user = UserModel(
            id: data._id ?? "",
            name: data.name,
            lastName: data.lastname ?? "",
            birthday: "", // data.birthday,
            gender: data.gender ?? "male",
            thumbnail: data.thumbnail ?? "",
            email: "", // data.email,
            locations: [],
            activities: [],
            description: "" // data.description
        )
        
        UserSettings.user = user
        
        return user
    }
}
