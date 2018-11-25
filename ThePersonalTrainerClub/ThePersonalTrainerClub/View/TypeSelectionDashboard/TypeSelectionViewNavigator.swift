//
//  TypeSelectionViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 23/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class TypeSelectionViewNavigator: TypeSelectionContract.Navigator {
    private var view: TypeSelectionContract.View
    
    init(view: TypeSelectionContract.View) {
        self.view = view
    }
    
    func navigateToTrainerView() {
        //TODO: Perform navigation when view is implemented: TrainerDashboardViewController()
    }
    
    func navigateToClientView() {
        //TODO: Perform navigation when view is implemented
    }
}
