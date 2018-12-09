//
//  UserSettingsViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 25/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation
import UIKit

class UserSettingsViewPresenter: BaseViewPresenter, UserSettingsContract.Presenter {
    private var view: UserSettingsContract.View
    private var trainerManagementUseCase: TrainerManagementUseCase
    private lazy var navigator: UserSettingsContract.Navigator = UserSettingsViewNavigator(view: view)
    
    init(view: UserSettingsContract.View, trainerManagementUseCase: TrainerManagementUseCase) {
        self.view = view
        self.trainerManagementUseCase = trainerManagementUseCase
    }
    
    func fetchUser() {
        if let user = UserSettings.user {
            view.setUser(user)
        }

        // view.showLoading()
        
        trainerManagementUseCase.fetchUser() { user, error, errorsMap in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else if let data = user {
                self.view.setUser(data)
            }
            
            // self.view.hideLoading()
        }
    }
    
    func setThumbnail(_ image: UIImage) {
        view.showLoading()
        
        trainerManagementUseCase.setUserThumbnail(image) { (success, error, errorsMap) in
            self.view.hideLoading()
            
            if error != nil {
                var message = String(format: NSLocalizedString("user_setting_server_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.fetchUser()
            }
        }
    }
    
    func onLogout() {
        UserSettings.token = ""
        UserSettings.user = nil
        navigator.navigateToLoginView()
    }
}
