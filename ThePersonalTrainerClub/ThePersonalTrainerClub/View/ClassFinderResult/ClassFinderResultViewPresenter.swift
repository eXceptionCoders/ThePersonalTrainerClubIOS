//
//  ClassFinderResultViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ClassFinderResultViewPresenter: BaseViewPresenter, ClassFinderResultContract.Presenter {
    private var view: ClassFinderResultContract.View
    
    init(view: ClassFinderResultContract.View) {
        self.view = view
    }
    
    func fetchClasses(_ query: ClassFinderQuery) {
        //view.showLoading()
        
        view.setClasses(UserSettings.user?.classes ?? [])
    }
    
    func onClassTapped() {
        
    }
}
