//
//  ClassFinderViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ClassFinderViewPresenter: BaseViewPresenter, ClassFinderContract.Presenter {
    private var view: ClassFinderContract.View
    
    init(view: ClassFinderContract.View) {
        self.view = view
    }
    
    func fetchUser() {
        if let user = UserSettings.user {
            view.setUser(user)
        }
    }
    
    func onSearch(sport: String, location: LocationModel, distance: Int) {
        // TODO
    }
}
