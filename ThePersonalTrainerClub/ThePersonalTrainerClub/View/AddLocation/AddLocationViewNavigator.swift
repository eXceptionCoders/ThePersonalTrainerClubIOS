//
//  AddLocationViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class AddLocationViewNavigator: AddLocationContract.Navigator {
    private var view: AddLocationContract.View
    
    init(view: AddLocationContract.View) {
        self.view = view
    }
}
