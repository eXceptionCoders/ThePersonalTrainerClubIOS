//
//  AddLocationUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 03/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class AddLocationUseCase {
    private var provider: LocationProvider
    
    init(provider: LocationProvider) {
        self.provider = provider
    }
    
    func addLocation(location: LocationModel, completion: @escaping (Bool?, Error?) -> Void) {
        provider.addLocation(model: location) { (success, error, errorResponse) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(success, nil)
            }
        }
    }
}
