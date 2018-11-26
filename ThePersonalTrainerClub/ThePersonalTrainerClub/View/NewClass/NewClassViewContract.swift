//
//  NewClassViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum NewClassContract {
    typealias View = NewClassView
    typealias Presenter = NewClassPresenter
    typealias Navigator = NewClassNavigator
}

protocol NewClassView: BaseContract.View {
    func resetInputs()
}

protocol NewClassPresenter: BaseContract.Presenter {
    func onCreate(sport: String, description: String, price: Float, quota: Int, location: LocationModel)
}

protocol NewClassNavigator: BaseContract.Navigator {
    
}
