//
//  RegisterViewControllerNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 08/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewNavigator: RegisterContract.Navigator {
    private var view: RegisterContract.View
    
    init(view: RegisterContract.View) {
        self.view = view
    }
    
    func navigateToLoginView() {
        (view as! UIViewController).navigationController?.popViewController(animated: true)
    }
}
