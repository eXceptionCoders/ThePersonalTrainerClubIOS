//
//  ClassFinderResultViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class ClassFinderResultViewNavigator: ClassFinderResultContract.Navigator {

    private var view: ClassFinderResultContract.View
    
    init(view: ClassFinderResultContract.View) {
        self.view = view
    }
    
    func navigateToClassDetail() {
        // TODO
    }
    
    func popBack() {
        (view as! UIViewController).navigationController?.popViewController(animated: true)
    }
}
