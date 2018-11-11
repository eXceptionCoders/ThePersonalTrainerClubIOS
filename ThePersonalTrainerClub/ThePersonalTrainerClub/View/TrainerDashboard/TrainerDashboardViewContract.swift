//
//  TrainerDashboardViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum TrainerDashboardContract {
    typealias View = TrainerDashboardView
    typealias Presenter = TrainerDashboardPresenter
    typealias Navigator = TrainerDashboardNavigator
}

protocol TrainerDashboardView: BaseContract.View {
    
}

protocol TrainerDashboardPresenter: BaseContract.Presenter {
    
}

protocol TrainerDashboardNavigator: BaseContract.Navigator {
    func navigateToTrainerManagement()
    func navigateToSwitchMode()
    func navigateToNewClass()
}
