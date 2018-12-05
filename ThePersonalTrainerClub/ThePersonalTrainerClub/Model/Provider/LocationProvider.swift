//
//  LocationProvider.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 01/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum LocationError: Error {
    case notFound
    case otherError
}

class LocationProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func deleteLocation(model: LocationModel, completion: @escaping (Bool?, Error?, [String: String]?) -> Void) {
        webService.load(DeleteLocationResponse.self, from: Endpoint.deleteLocation(requestModel: LocationProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, error, responseObject?.error)
                default:
                    completion(false, error, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
    
    func addLocation(model: LocationModel, completion: @escaping (Bool?, Error?, [String: String]?) -> Void) {
        webService.load(AddLocationResponse.self, from: Endpoint.addLocation(requestModel: AddLocationProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unprocessableEntity:
                    completion(false, error, responseObject?.error)
                default:
                    completion(false, error, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}

private class LocationProviderMapper {
    // TODO: The locations don't have an id
    class func mapModelToEntity(model: LocationModel) -> DeleteLocationRequest {
        return DeleteLocationRequest(
            id: "" // model.id
        )
    }
}

private class AddLocationProviderMapper {
    class func mapModelToEntity(model: LocationModel) -> AddLocationRequest {
        return AddLocationRequest(
            description: model.description,
            longitude: Double(model.coordinates[0]),
            latitude: Double(model.coordinates[1])
        )
    }
}
