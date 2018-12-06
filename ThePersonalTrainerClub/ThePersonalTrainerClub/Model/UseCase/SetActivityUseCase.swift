//
//  SetActivityUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 29/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class SetActivityUseCase {
    private var activityProvider: SetActivitiesProvider
    private var userProvider: UserProvider
    
    init(activityProvider: SetActivitiesProvider, userProvider: UserProvider) {
        self.activityProvider = activityProvider
        self.userProvider = userProvider
    }
    
    func setActivities(model: SetActivitiesModel, completion: @escaping (Bool?, Error?, [String:String]?) -> Void) {
        activityProvider.setSports(model: model) { (success, error, errorsMap) in
            if success {
                self.userProvider.fetchUser(completion: { (model, error, errorResponse) in
                    if error == nil {
                        completion(success, error, errorsMap)
                    } else {
                        completion(nil, error, errorsMap)
                    }
                })
            } else {
                completion(nil, error, errorsMap)
            }
        }
    }
}
