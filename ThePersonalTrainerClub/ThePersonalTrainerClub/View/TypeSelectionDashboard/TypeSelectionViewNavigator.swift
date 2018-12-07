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
        if (UserSettings.showCoachView) {
            return
        }
        
        UserSettings.showCoachView = true
        navigateToMainView()
    }
    
    func navigateToClientView() {
        if (!UserSettings.showCoachView) {
            return
        }
        
        UserSettings.showCoachView = false
        navigateToMainView()
    }
    
    private func navigateToMainView() {
        let trainerDashboardVC = TrainerDashboardViewController()
        (view as! UIViewController).present(trainerDashboardVC, animated: true, completion: nil)
    }
}
