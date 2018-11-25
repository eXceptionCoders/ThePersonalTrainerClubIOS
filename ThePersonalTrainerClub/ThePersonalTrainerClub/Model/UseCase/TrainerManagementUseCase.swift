//
//  TrainerManagementUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class TrainerManagementUseCase {
    
    private var userProvider: UserProvider
    private var classProvider: ClassProvider
    
    init(userProvider: UserProvider, classProvider: ClassProvider) {
        self.userProvider = userProvider
        self.classProvider = classProvider
    }
    
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void) {
        userProvider.fetchUser(completion: completion)
    }
    
    func fetchClasses(_ id: String, completion: @escaping ([ClassModel]?, Error?) -> Void) {
        classProvider.fetchClassesForTrainer(id, completion: completion)
    }
}
