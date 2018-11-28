//
//  AddSportViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class AddSportViewPresenter: BaseViewPresenter, AddSportContract.Presenter {
    
    private var view: AddSportContract.View
    private lazy var navigator: AddSportContract.Navigator = AddSportViewNavigator(view: view)
    
    init(view: AddSportContract.View) {
        self.view = view
    }
}
