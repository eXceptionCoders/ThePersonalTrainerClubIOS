//
//  TrainerManagementViewNavigator.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TrainerManagementViewNavigator: TrainerManagementContract.Navigator {
    private var view: TrainerManagementContract.View
    
    init(view: TrainerManagementContract.View) {
        self.view = view
    }
    
    func navigateToAddSport() {
        let addSportViewController = AddSportViewController()
        addSportViewController.hidesBottomBarWhenPushed = true

        (view as! UIViewController).navigationController?.pushViewController(addSportViewController, animated: true)
    }
    
    func navigateToAddLocation() {
        let addLocationViewController = AddLocationViewController()
        addLocationViewController.hidesBottomBarWhenPushed = true

        (view as! UIViewController).navigationController?.pushViewController(addLocationViewController, animated: true)
    }
}
