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
    
    func fetchTrainer(_ id: String) {
        view.showLoading()
        
        if (id.isEmpty) {
            return
        }
        
        trainerManagementUseCase.fetchUser() { user, error, errorsMap in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else if let data = user {
                self.view.setTrainer(data)
            }
            
            self.view.hideLoading()
        }
    }
    
    func fetchClasses(_ id: String) {
        if (id.isEmpty) {
            return
        }
        
        trainerManagementUseCase.fetchClasses(id) { classes, error, errorsMap in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else if let data = classes {
                self.view.setClasses(data)
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
}
