//
//  AddLocationUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 03/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class AddLocationUseCase {
    private var locationProvider: LocationProvider
    
    init(locationProvider: LocationProvider) {
        self.locationProvider = locationProvider
    }
    
    func addLocation(location: LocationModel, completion: @escaping (Bool?, Error?, [String:String]?) -> Void) {
        locationProvider.addLocation(model: location) { (success, error, errorResponse) in
            if error != nil {
                completion(nil, error, errorResponse)
            } else {
                completion(success, nil, errorResponse)
            }
        }
    }
}
