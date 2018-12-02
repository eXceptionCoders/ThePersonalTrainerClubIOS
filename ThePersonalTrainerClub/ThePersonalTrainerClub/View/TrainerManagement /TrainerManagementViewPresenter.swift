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
    private var findAthleteClassesUseCase: FindAthleteClassesUseCase
    private lazy var navigator: TrainerManagementContract.Navigator = TrainerManagementViewNavigator(view: view)
    
    init(view: TrainerManagementContract.View, trainerManagementUseCase: TrainerManagementUseCase, findAthleteClassesUseCase: FindAthleteClassesUseCase) {
        self.view = view
        self.trainerManagementUseCase = trainerManagementUseCase
        self.findAthleteClassesUseCase = findAthleteClassesUseCase
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
    
    func fetchClasses() {
        view.showLoading()
        
        if (UserSettings.user?.coach ?? false) && UserSettings.showCoachView {
            //Trainer: Obtener clases de UserSettings.user
            view.hideLoading()
            
        } else {
            findAthleteClassesUseCase.findClasses { (athleteModel, error) in
                self.view.hideLoading()
                
                if error != nil {
                    self.view.showAlertMessage(title: "Error", message: error.debugDescription)
                } else {
                    self.view.setClasses(athleteModel!)
                }
            }
        }
    }
    
    func onAddSportTapped() {
        navigator.navigateToAddSport()
    }
    
    func onAddLocationTapped() {
        navigator.navigateToAddLocation()
    }
    
    func onLocationTapped(location: LocationModel) {
        view.showLoading()
        
        
    }
}
