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
    
    func fetchUser(completion: @escaping (UserModel?, Error?, [String: String]?) -> Void) {
        webService.load(UserResponse.self, from: Endpoint.userData(requestModel: UserRequest())) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.notFound:
                    completion(nil, UserError.notFound, responseObject?.error)
                default:
                    completion(nil, UserError.otherError, responseObject?.error)
                }
                
                UserSettings.token = ""
            } else if let response = responseObject, let data = response.data {
                completion(UserProviderMapper.mapEntityToModel(data: data), nil, nil)
            } else {
                completion(nil, UserError.otherError, responseObject?.error)
                UserSettings.token = ""
            }
        }
    }
}

private class UserProviderMapper {
    class func mapEntityToModel(data: UserEntity) -> UserModel {
        
        var locations: [LocationModel] = []
        if let loc = data.locations {
            locations = loc.map {
                return LocationModel(
                    // id: $0._id,
                    type: $0.type,
                    coordinates: $0.coordinates,
                    description: $0.description ?? ""
                )
            }
        }
        
        var activities: [ActivityModel] = []
        if let act = data.sports {
            activities = act.map {
                return ActivityModel(
                    id: $0._id,
                    name: $0.name,
                    icon: $0.icon ?? "",
                    category: ""
                )
            }
        }
        
        let user = UserModel(
            id: data._id,
            name: data.name,
            lastName: data.lastname ?? "",
            coach: data.coach,
            birthday: "", // data.birthday,
            gender: data.gender,
            thumbnail: data.thumbnail ?? "",
            email: data.email,
            locations: locations,
            activities: activities,
            description: "", // data.description
            classes: (data.classes ?? []).map { ClassProviderMapper.mapEntityToModel(data: $0) },
            activeBookings: (data.activeBookings ?? []).map { ClassProviderMapper.mapEntityToModel(data: $0) }
        )
        
        UserSettings.user = user
        
        return user
    }
}
