//
//  ClassDetailViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class ClassDetailViewNavigator: ClassDetailContract.Navigator {
    private var view: ClassDetailContract.View
    
    init(view: ClassDetailContract.View) {
        self.view = view
    }
    
    func popBack() {
        (view as! UIViewController).navigationController?.popViewController(animated: true)
    }
}
