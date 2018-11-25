//
//  ActivityProvider.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ActivityProvider {
    enum ActivityError: Error {
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchActivities(completion: @escaping ([ActivityModel]?, Error?) -> Void) {
        webService.load(SportResponse.self, from: Endpoint.sports(requestModel: SportRequest())) { responseObject, error in
            if let error = error {
                switch error {
                default:
                    completion(nil, ActivityError.otherError)
                }
            } else if let response = responseObject {
                completion(ActivityProviderMapper.mapEntityToModel(response: response), nil)
            } else {
                completion(nil, ActivityError.otherError)
            }
        }
    }
}

private class ActivityProviderMapper {
    class func mapEntityToModel(response: SportResponse) -> [ActivityModel] {
        return response.data.map {
            return ActivityModel(
                id: $0._id,
                name: $0.name,
                description: "", // $0.description,
                thumbnail: $0.thumbnail,
                category: $0.category
            )
        }
    }
}
