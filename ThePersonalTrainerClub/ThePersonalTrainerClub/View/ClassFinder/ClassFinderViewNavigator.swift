//
//  ClassFinderViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class ClassFinderViewNavigator: ClassFinderContract.Navigator {

    private var view: ClassFinderContract.View
    
    init(view: ClassFinderContract.View) {
        self.view = view
    }

    func navigateToClassFinderResult(_ query: ClassFinderQuery) {
        let classFinderResultViewController = ClassFinderResultViewController(query: query)
        classFinderResultViewController.hidesBottomBarWhenPushed = true
        
        (view as! UIViewController).navigationController?.pushViewController(classFinderResultViewController, animated: true)
    }
}
