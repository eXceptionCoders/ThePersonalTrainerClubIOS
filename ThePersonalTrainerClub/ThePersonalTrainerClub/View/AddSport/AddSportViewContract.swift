//
//  AddSportViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum AddSportContract {
    typealias View = AddSportView
    typealias Presenter = AddSportPresenter
    typealias Navigator = AddSportNavigator
}

protocol AddSportView: BaseContract.View {
    
}

protocol AddSportPresenter: BaseContract.Presenter {
}

protocol AddSportNavigator: BaseContract.Navigator {
}
