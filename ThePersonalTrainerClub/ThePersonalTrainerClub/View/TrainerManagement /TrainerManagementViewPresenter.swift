//
//  TrainerManagementViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class TrainerManagementViewPresenter: BaseViewPresenter, TrainerManagementContract.Presenter {
    private var view: TrainerManagementContract.View
    private var trainerManagementUseCase: TrainerManagementUseCase
    
    private lazy var navigator: TrainerManagementContract.Navigator = TrainerManagementViewNavigator(view: view)
    
    init(view: TrainerManagementContract.View, trainerManagementUseCase: TrainerManagementUseCase) {
        self.view = view
        self.trainerManagementUseCase = trainerManagementUseCase
    }
    
    func fetchUser() {
        view.showLoading()
        
        trainerManagementUseCase.fetchUser() { user, error, errorsMap in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else if let data = user {
                self.view.setUser(data)
                
                if (data.coach && UserSettings.showCoachView) {
                    self.view.setClasses(data.classes ?? [])
                } else {
                    self.view.setClasses(data.activeBookings ?? [])
                }
            }
            
            self.view.hideLoading()
        }
    }
    
    func onAddSportTapped() {
        navigator.navigateToAddSport()
    }
    
    func onAddLocationTapped() {
        navigator.navigateToAddLocation()
    }
    
    func onLocationTapped(location: LocationModel) {
        // TODO
        // view.showLoading()
        
        
    }
}
