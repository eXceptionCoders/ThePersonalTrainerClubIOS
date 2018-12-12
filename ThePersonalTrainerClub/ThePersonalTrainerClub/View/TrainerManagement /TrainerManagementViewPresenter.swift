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
    private var removeLocationUseCase: RemoveLocationUseCase
    
    private lazy var navigator: TrainerManagementContract.Navigator = TrainerManagementViewNavigator(view: view)
    
    init(view: TrainerManagementContract.View, trainerManagementUseCase: TrainerManagementUseCase, removeLocationUseCase: RemoveLocationUseCase) {
        self.view = view
        self.trainerManagementUseCase = trainerManagementUseCase
        self.removeLocationUseCase = removeLocationUseCase
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
        removeLocationUseCase.removeLocation(location: location) { success, error, errorsMap in
            self.view.hideLoading()
            
            if error != nil {
                var message = String(format: NSLocalizedString("remove_location_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.fetchUser()
            }
        }
    }
    
    func onClassTapped(_ data: ClassModel) {
        self.navigator.navigateToClassDetail(model: data)
    }
    
    func onDeleteClass(_ data: ClassModel) {
        if !UserSettings.showCoachView {
            guard let bookingId = data.booking else {
                return
            }

            view.showLoading()
            
            trainerManagementUseCase.deleteBooking(bookId: bookingId) { (succes, error, errorsMap) in
                
                self.view.hideLoading()
                if error != nil {
                    var message = String(format: NSLocalizedString("remove_class_error", comment: ""))
                    
                    for (key, detail) in errorsMap ?? [:] {
                        message = String(format: "%@ \n%@: %@", message, key, detail)
                    }
                    
                    self.view.showAlertMessage(title: nil, message: message)
                } else {
                    self.fetchUser()
                }
            }
        } else {
            view.showLoading()
            trainerManagementUseCase.deleteClass(classId: data.id) { (succes, error, errorsMap) in
                
                self.view.hideLoading()
                if error != nil {
                    var message = String(format: NSLocalizedString("remove_booking_error", comment: ""))
                    
                    for (key, detail) in errorsMap ?? [:] {
                        message = String(format: "%@ \n%@: %@", message, key, detail)
                    }
                    
                    self.view.showAlertMessage(title: nil, message: message)
                } else {
                    self.fetchUser()
                }
            }
        }
    }
}
