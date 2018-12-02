//
//  FindAthleteClassesUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 30/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class FindAthleteClassesUseCase {
    private var provider: ClassProvider
    
    init(provider: ClassProvider) {
        self.provider = provider
    }
    
    func findClasses(completion: @escaping ([ClassModel]?, Error?) -> Void) {
        provider.fetchClassesForAthlete { (athleteModel, error, errorResponse) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(athleteModel, nil)
            }
        }
    }
}
