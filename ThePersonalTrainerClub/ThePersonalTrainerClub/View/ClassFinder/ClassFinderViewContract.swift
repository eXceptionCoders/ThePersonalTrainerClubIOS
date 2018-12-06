//
//  ClassFinderViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum ClassFinderContract {
    typealias View = ClassFinderView
    typealias Presenter = ClassFinderPresenter
    typealias Navigator = ClassFinderNavigator
}

protocol ClassFinderView: BaseContract.View {
    
}

protocol ClassFinderPresenter: BaseContract.Presenter {
    func onSearch(sport: String, location: LocationModel, distance: Int)
}

protocol ClassFinderNavigator: BaseContract.Navigator {
    func navigateToClassFinderResult()
}
