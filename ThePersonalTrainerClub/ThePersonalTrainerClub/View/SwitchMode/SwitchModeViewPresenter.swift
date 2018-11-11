//
//  SwitchModeViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class SwitchModeViewPresenter: BaseViewPresenter, SwitchModeContract.Presenter {
    
    private var view: SwitchModeContract.View
    private lazy var navigator: SwitchModeContract.Navigator = SwitchModeViewNavigator(view: view)
    
    init(view: SwitchModeContract.View) {
        self.view = view
    }
}
