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
    
    func setSports(model: SetActivitiesModel, completion: @escaping (Bool, Error?) -> Void) {
        webService.load(SetSportResponse.self, from: Endpoint.setSports(requestModel: SetActivitiesProviderMapper.mapModelToEntity(model: model))) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unauthorized:
                    completion(false, SetActivitiesError.userPasswordNotFound)
                case WebServiceError.unprocessableEntity:
                    completion(false, SetActivitiesError.incorrectEntry)
                default:
                    completion(false, SetActivitiesError.otherError)
                }
            } else if let response = responseObject {
                completion(true, nil)
            } else {
                completion(false, SetActivitiesError.otherError)
            }
        }
    }
}

private class SetActivitiesProviderMapper {
    class func mapModelToEntity(model: SetActivitiesModel) -> SetSportRequest {
        return SetSportRequest(listSport: model.activities)
    }
}
