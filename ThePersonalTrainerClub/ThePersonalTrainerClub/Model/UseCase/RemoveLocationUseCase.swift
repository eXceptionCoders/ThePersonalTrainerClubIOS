//
//  RemoveLocationUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class RemoveLocationUseCase {
    private var locationProvider: LocationProvider
    
    init(locationProvider: LocationProvider) {
        self.locationProvider = locationProvider
    }
    
    func removeLocation(location: LocationModel, completion: @escaping (Bool?, Error?, [String:String]?) -> Void) {
        locationProvider.deleteLocation(model: location) { (success, error, errorResponse) in
            if error != nil {
                completion(nil, error, errorResponse)
            } else {
                completion(success, nil, errorResponse)
            }
        }
    }
}
