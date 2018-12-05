//
//  NewClassProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ClassProvider {
    enum ClassError: Error {
        case unprocessableEntity
        case notFound
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func create(model: NewClassModel, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(NewClassResponse.self, from: Endpoint.newClass(requestModel: ClassProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, ClassError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, ClassError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}

private class ClassProviderMapper {
    class func mapModelToEntity(model: NewClassModel) -> NewClassRequest {
        return NewClassRequest(
            instructor: model.instructor,
            sport: model.sport,
            location: LocationEntity(
                type: model.location.type,
                description: model.location.description,
                coordinates: model.location.coordinates
            ),
            description: model.description,
            price: model.price,
            duration: model.duration,
            maxusers: model.maxusers
        )
    }
}

