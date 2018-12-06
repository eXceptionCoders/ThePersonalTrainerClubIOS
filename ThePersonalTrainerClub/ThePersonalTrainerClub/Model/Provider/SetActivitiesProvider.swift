//
//  SetActivitiesProvider.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 29/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum SetActivitiesError: Error {
    case notFound
    case userPasswordNotFound
    case incorrectEntry
    case otherError
}

class SetActivitiesProvider {
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func setSports(model: SetActivitiesModel, completion: @escaping (Bool, Error?, [String: String]?) -> Void) {
        webService.load(SetSportResponse.self, from: Endpoint.setSports(requestModel: SetActivitiesProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unauthorized:
                    completion(false, SetActivitiesError.userPasswordNotFound, responseObject?.error)
                case WebServiceError.unprocessableEntity:
                    completion(false, SetActivitiesError.incorrectEntry, responseObject?.error)
                default:
                    completion(false, SetActivitiesError.otherError, responseObject?.error)
                }
            } else {
                completion(true, nil, nil)
            }
        }
    }
}

private class SetActivitiesProviderMapper {
    class func mapModelToEntity(model: SetActivitiesModel) -> SetSportRequest {
        return SetSportRequest(sports: model.activities)
    }
}
