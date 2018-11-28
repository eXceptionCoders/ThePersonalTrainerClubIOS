//
//  AddSportViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class AddSportViewNavigator: AddSportContract.Navigator {
    private var view: AddSportContract.View
    
    init(view: AddSportContract.View) {
        self.view = view
    }
}
