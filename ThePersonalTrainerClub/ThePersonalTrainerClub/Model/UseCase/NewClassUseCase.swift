//
//  NewClassUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class NewClassUseCase {
    
    private var newClassProvider: ClassProvider
    
    init(newClassProvider: ClassProvider) {
        self.newClassProvider = newClassProvider
    }
    
    func create(model: NewClassModel, completion: @escaping (Bool?, Error?) -> Void) {
        newClassProvider.create(model: model, completion: completion)
    }
    
}
