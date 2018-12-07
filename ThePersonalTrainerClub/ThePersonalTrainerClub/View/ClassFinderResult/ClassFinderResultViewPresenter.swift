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
    private var findClassesUseCase: FindClassesUseCase
    
    private var page = 0
    private var perPage = 20
    
    private var _total = 0;
    var total: Int {
        get { return _total }
    }
    
    init(view: ClassFinderResultContract.View, findClassesUseCase: FindClassesUseCase) {
        self.view = view
        self.findClassesUseCase = findClassesUseCase
    }
    
    func fetchClasses(_ query: ClassFinderQuery) {
        guard let user = UserSettings.user else {
            return
        }
        
        view.showLoading()
        
        let sport = user.activities[query.sportIndex]
        let location = user.locations[query.locationIndex]
        
        var price = ""
        if query.priceFrom != nil && query.priceTo != nil {
            price = "\(query.priceFrom!)-\(query.priceTo!)"
        } else if query.priceFrom != nil {
            price = "\(query.priceFrom!)-"
        } else if query.priceTo != nil {
            price = "-\(query.priceTo!)"
        }
        
        findClassesUseCase.find(sport: sport.id, location: location, distance: query.distance, price: price, page: page, perPage: perPage) { (result, error, errorsMap) in
            self.view.hideLoading()
            
            if error != nil {
                var message = String(format: NSLocalizedString("class_finder_result_server_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
                self.view.setClasses([], 0)
            } else {
                self._total = result?.total ?? 0
                self.view.setClasses(result?.classes ?? [], result?.total ?? 0)
            }
        }
    }
    
    func onClassTapped() {
        
    }
}
