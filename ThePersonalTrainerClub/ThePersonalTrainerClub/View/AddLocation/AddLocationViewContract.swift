//
//  AddLocationViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum AddLocationContract {
    typealias View = AddLocationView
    typealias Presenter = AddLocationPresenter
    typealias Navigator = AddLocationNavigator
}

protocol AddLocationView: BaseContract.View {
    func onLocationSaved()
    func onLocationError()
}

protocol AddLocationPresenter: BaseContract.Presenter {
    func onAddLocation(description: String, latitude: Double, longitude: Double)
}

protocol AddLocationNavigator: BaseContract.Navigator {
    func popBack()
}
