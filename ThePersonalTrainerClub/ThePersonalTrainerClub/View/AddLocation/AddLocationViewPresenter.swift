//
//  AddLocationViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class AddLocationViewPresenter: BaseViewPresenter, AddLocationContract.Presenter {
    
    private var view: AddLocationContract.View
    private var addLocationUseCase: AddLocationUseCase
    private lazy var navigator: AddLocationContract.Navigator = AddLocationViewNavigator(view: view)
    
    init(view: AddLocationContract.View, addLocationUseCase: AddLocationUseCase) {
        self.view = view
        self.addLocationUseCase = addLocationUseCase
    }
    
    func onAddLocation(description: String, latitude: Double, longitude: Double) {
        let locationModel = LocationModel(type: "Point",
                                          coordinates: [latitude, longitude],
                                          description: description)
        
        addLocationUseCase.addLocation(location: locationModel) { (success, error) in
            print("")
        }
    }
}
