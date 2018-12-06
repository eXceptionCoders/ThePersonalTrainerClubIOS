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
    
    func onSearch(sportIndex: Int, locationIndex: Int, distance: Int, priceFrom: Int, priceTo: Int) {
        /* TODO
        let sport = UserSettings.user?.activities[sportIndex]
        let location = UserSettings.user?.locations[locationIndex]
        
        view.showLoading()
        */
    }
}
