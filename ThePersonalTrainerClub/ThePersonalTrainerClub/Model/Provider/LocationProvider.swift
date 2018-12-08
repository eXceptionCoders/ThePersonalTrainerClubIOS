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
    case unauthorized
    case forbiddenError
    case unprocessableEntity
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
                case WebServiceError.unauthorized:
                    completion(false, LocationError.unauthorized, responseObject?.error)
                case WebServiceError.forbiddenError:
                    completion(false, LocationError.forbiddenError, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, LocationError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, LocationError.otherError, responseObject?.error)
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
                case WebServiceError.unauthorized:
                    completion(false, LocationError.unauthorized, responseObject?.error)
                case WebServiceError.forbiddenError:
                    completion(false, LocationError.forbiddenError, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, LocationError.unprocessableEntity, responseObject?.error)
                default:
                    completion(false, LocationError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}

private class LocationProviderMapper {
    class func mapModelToEntity(model: LocationModel) -> DeleteLocationRequest {
        return DeleteLocationRequest(
            description: model.description,
            longitude: Double(model.coordinates[0]),
            latitude: Double(model.coordinates[1])
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
