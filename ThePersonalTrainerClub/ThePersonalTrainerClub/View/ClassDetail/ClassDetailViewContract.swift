//
//  ClassDetailViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum ClassDetailContract {
    typealias View = ClassDetailView
    typealias Presenter = ClassDetailPresenter
    typealias Navigator = ClassDetailNavigator
}

protocol ClassDetailView: BaseContract.View {
    
}

protocol ClassDetailPresenter: BaseContract.Presenter {
    func book(_ class: String)
}

protocol ClassDetailNavigator: BaseContract.Navigator {
    func popBack()
}
