//
//  LoginViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class LoginViewNavigator: LoginContract.Navigator {
    private var view: LoginContract.View
    
    init(view: LoginContract.View) {
        self.view = view
    }
    
    func navigateToRegisterView() {
        let registerViewController = RegisterViewController()
        (view as! UIViewController).navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func navigateToMainView() {
        let trainerDashboardVC = TrainerDashboardViewController()
        (view as! UIViewController).present(trainerDashboardVC, animated: true, completion: nil)
    }
}
