//
//  FindClassesUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 07/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class FindClassesUseCase {
    
    private var classProvider: ClassProvider
    
    init(classProvider: ClassProvider) {
        self.classProvider = classProvider
    }
    
    func find(sport: String, location: LocationModel, distance: Int, price: String, page: Int, perPage: Int, completion: @escaping (FindClassesModel?, Error?, [String: String]?) -> Void) {
        classProvider.find(sport: sport, location: location, distance: distance, price: price, page: page, perPage: perPage) { (result, error, errorsMap) in
            completion(result, error, errorsMap)
        }
    }
}
