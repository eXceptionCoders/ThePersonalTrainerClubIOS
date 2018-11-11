//
//  SwitchModeViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum SwitchModeContract {
    typealias View = SwitchModeView
    typealias Presenter = SwitchModePresenter
    typealias Navigator = SwitchModeNavigator
}

protocol SwitchModeView: BaseContract.View {
    
}

protocol SwitchModePresenter: BaseContract.Presenter {
    
}

protocol SwitchModeNavigator: BaseContract.Navigator {
    func navigateToTrainerMainView()
    func navigateToAthleteMainView()
}
