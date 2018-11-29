//
//  ActivityUseCase.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 29/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ActivityUseCase {
    private var activityProvider: ActivityProvider
    
    init(activityProvider: ActivityProvider) {
        self.activityProvider = activityProvider
    }
    
    func getAllActivities(completion: @escaping ([ActivityModel]?, Error?) -> Void) {
        activityProvider.fetchActivities { success, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(success, nil)
            }
        }
    }
}
