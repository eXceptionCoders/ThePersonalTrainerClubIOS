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
    
    func onCreate(sport: String, description: String, price: Float, quota: Int, location: LocationModel) {
        view.showLoading()
        
        if (sport.isEmpty || description.isEmpty) {
            view.showAlertMessage(title: "Check the data", message: "Please, fills the required fields")
            return
        }
        
        let model = NewClassModel(
            id: "",
            sport: sport,
            location: location,
            description: description,
            price: price,
            quota: quota,
            duration: 30
        )
        newClassUseCase.create(model: model) { loggedIn, error in
            if let error = error {
                self.view.showAlertMessage(title: nil, message: "\(error)")
            } else {
                self.view.showAlertMessage(title: nil, message: "OK")
            }
            
            self.view.hideLoading()
        }
    }
}
