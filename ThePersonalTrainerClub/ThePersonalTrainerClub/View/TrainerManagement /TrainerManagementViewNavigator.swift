//
//  TrainerManagementViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class TrainerManagementViewNavigator: TrainerManagementContract.Navigator {
    
    private var view: TrainerManagementContract.View
    
    init(view: TrainerManagementContract.View) {
        self.view = view
    }
    
    func navigateToAddActivitiesView() {
        // TODO
    }
    
}
