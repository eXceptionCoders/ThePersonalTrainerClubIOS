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
    
    func onCreate(name: String, description: String, price: Decimal, quota: Int, photo: String) {
        view.showLoading()
        
        if (name.isEmpty || description.isEmpty) {
            return
        }
        
        let model = ClassModel(
            id: "",
            name: name,
            description: description,
            price: price,
            photo: photo,
            quota: quota
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
