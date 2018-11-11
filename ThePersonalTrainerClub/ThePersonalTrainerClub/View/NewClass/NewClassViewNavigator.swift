//
//  NewClassViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class NewClassViewNavigator: NewClassContract.Navigator {
    private var view: NewClassContract.View
    
    init(view: NewClassContract.View) {
        self.view = view
    }
    
}
