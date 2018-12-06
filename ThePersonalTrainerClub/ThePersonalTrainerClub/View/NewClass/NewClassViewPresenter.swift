//
//  NewClassViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class NewClassViewPresenter: BaseViewPresenter, NewClassContract.Presenter {

    private var view: NewClassContract.View
    private var newClassUseCase: NewClassUseCase
    private lazy var navigator: NewClassContract.Navigator = NewClassViewNavigator(view: view)
    
    init(view: NewClassContract.View, newClassUseCase: NewClassUseCase) {
        self.view = view
        self.newClassUseCase = newClassUseCase
    }
    
    func fetchUser() {
        if let user = UserSettings.user {
            view.setUser(user)
        }
    }
    
    func onCreate(sport: String, description: String, price: Float, quota: Int, location: LocationModel) {
        if (sport.isEmpty || description.isEmpty) {
            view.showAlertMessage(title: nil, message: NSLocalizedString("newclass_checkfields", comment: ""))
            return
        }

        view.showLoading()
        
        let model = NewClassModel(
            instructor: UserSettings.user?.id ?? "",
            sport: sport,
            location: location,
            description: description,
            price: price,
            maxusers: quota,
            duration: 30
        )
        newClassUseCase.create(model: model) { loggedIn, error, errorsMap in
            self.view.hideLoading()
            
            if error != nil {
                var message = String(format: NSLocalizedString("newclass_server_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.view.showAlertMessage(title: nil, message: NSLocalizedString("newclass_class_created", comment: ""))
                self.view.resetInputs()
            }
        }
    }
}
