//
//  NewClassUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class NewClassUseCase {
    
    private var classProvider: ClassProvider
    
    init(classProvider: ClassProvider) {
        self.classProvider = classProvider
    }
    
    func create(model: NewClassModel, completion: @escaping (Bool?, Error?, [String: String]?) -> Void) {
        classProvider.create(model: model, completion: completion)
    }
    
}
