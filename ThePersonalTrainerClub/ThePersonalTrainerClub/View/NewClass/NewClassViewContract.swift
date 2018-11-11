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
    
}

protocol NewClassPresenter: BaseContract.Presenter {
    func onCreate(name: String, description: String, price: Decimal, quota: Int, photo: String)
}

protocol NewClassNavigator: BaseContract.Navigator {
    
}
