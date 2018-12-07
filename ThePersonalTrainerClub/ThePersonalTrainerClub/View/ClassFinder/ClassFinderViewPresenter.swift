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
    
    private lazy var navigator: ClassFinderContract.Navigator = ClassFinderViewNavigator(view: view)
    
    init(view: ClassFinderContract.View) {
        self.view = view
    }
    
    func fetchUser() {
        if let user = UserSettings.user {
            view.setUser(user)
        }
    }
    
    func saveLastQuery(_ query: ClassFinderQuery) {
        UserSettings.lastQuery = query
    }
    
    func lastQuery() -> ClassFinderQuery? {
        return UserSettings.lastQuery
    }
    
    func onSearch(sportIndex: Int, locationIndex: Int, distance: Int, priceFrom: Int, priceTo: Int) {
        let query = ClassFinderQuery(
            sportIndex: sportIndex,
            locationIndex: locationIndex,
            distance: distance * 1000, // KM to meters
            priceFrom: priceFrom > 1 ? priceFrom : nil,
            priceTo: priceTo < 50 ? priceTo : nil
        )
        
        saveLastQuery(query)
        
        navigator.navigateToClassFinderResult(query)
    }
}
