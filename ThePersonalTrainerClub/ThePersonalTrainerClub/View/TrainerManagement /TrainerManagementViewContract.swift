//
//  TrainerManagementViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum TrainerManagementContract {
    typealias View = TrainerManagementView
    typealias Presenter = TrainerManagementPresenter
    typealias Navigator = TrainerManagementNavigator
}

protocol TrainerManagementView: BaseContract.View {
    func setUser(_ user: UserModel)
    func setClasses(_ classes: [ClassModel])
}

protocol TrainerManagementPresenter: BaseContract.Presenter {
    func fetchUser()
    func onLocationTapped(location: LocationModel)
    func onAddSportTapped()
    func onAddLocationTapped()
    func onClassTapped(_ data: ClassModel)
}

protocol TrainerManagementNavigator: BaseContract.Navigator {
    func navigateToAddSport()
    func navigateToAddLocation()
    func navigateToClassDetail(model: ClassModel)
}
