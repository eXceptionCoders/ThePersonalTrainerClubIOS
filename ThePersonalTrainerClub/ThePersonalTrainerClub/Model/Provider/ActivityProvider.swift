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
        case unauthorized
        case forbiddenError
        case otherError
    }
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchActivities(completion: @escaping ([ActivityModel]?, Error?, [String: String]?) -> Void) {
        webService.load(SportResponse.self, from: Endpoint.sports(requestModel: SportRequest())) { responseObject, error in
            if let error = error {
                switch error {
                case WebServiceError.unauthorized:
                    completion(nil, ActivityError.unauthorized, responseObject?.error)
                case WebServiceError.forbiddenError:
                    completion(nil, ActivityError.forbiddenError, responseObject?.error)
                default:
                    completion(nil, ActivityError.otherError, responseObject?.error)
                }
            } else if let response = responseObject {
                completion(ActivityProviderMapper.mapEntityToModel(response: response), nil, nil)
            } else {
                completion(nil, ActivityError.otherError, responseObject?.error)
            }
        }
        
        /*
        //TODO: Remove mock
        completion([
            ActivityModel(
                id: "1",
                name: "baloncesto",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/baloncesto.png",
                category: "a"
            ),
            ActivityModel(
                id: "2",
                name: "balonmano",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/balonmano.png",
                category: "a"
            ),
            ActivityModel(
                id: "3",
                name: "boxeo",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/boxeo.png",
                category: "a"
            ),
            ActivityModel(
                id: "4",
                name: "futbol",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/futbol.png",
                category: "a"
            ),
            ActivityModel(
                id: "5",
                name: "jugo",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/jugo.png",
                category: "a"
            ),
            ActivityModel(
                id: "6",
                name: "karate",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/karate.png",
                category: "b"
            ),
            ActivityModel(
                id: "7",
                name: "natacion",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/natacion.png",
                category: "b"
            ),
            ActivityModel(
                id: "8",
                name: "padel",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/padel.png",
                category: "b"
            ),
            ActivityModel(
                id: "9",
                name: "remo",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/remo.png",
                category: "b"
            ),
            ActivityModel(
                id: "10",
                name: "esgrima",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/swordsman.png",
                category: "b"
            ),
            ActivityModel(
                id: "11",
                name: "tenis",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/tenis.png",
                category: "c"
            ),
            ActivityModel(
                id: "12",
                name: "vela",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/vela.png",
                category: "c"
            ),
            ActivityModel(
                id: "13",
                name: "voleibol",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/voleibol.png",
                category: "c"
            ),
            ActivityModel(
                id: "14",
                name: "waterpolo",
                icon: "https://thepersonaltrainerclubcdn.azureedge.net/activities/waterpolo.png",
                category: "c"
            )
        ], nil)
        */
    }
}

private class ActivityProviderMapper {
    class func mapEntityToModel(response: SportResponse) -> [ActivityModel] {
        return (response.data ?? []).map {
            return ActivityModel(
                id: $0._id,
                name: $0.name,
                icon: $0.icon ?? "",
                category: "" // $0.category ?? ""
            )
        }
    }
}
