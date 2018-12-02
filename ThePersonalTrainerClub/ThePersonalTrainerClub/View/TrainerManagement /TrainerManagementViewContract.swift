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
    func setTrainer(_ trainer: UserModel)
    func setClasses(_ classes: [ClassModel])
}

protocol TrainerManagementPresenter: BaseContract.Presenter {
    func fetchTrainer(_ id: String)
    func fetchClasses()
    func onLocationTapped(location: LocationModel)
    func onAddSportTapped()
    func onAddLocationTapped()
}

protocol TrainerManagementNavigator: BaseContract.Navigator {
    func navigateToAddSport()
    func navigateToAddLocation()
}
