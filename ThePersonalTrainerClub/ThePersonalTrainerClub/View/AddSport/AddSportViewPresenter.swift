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
    private var activityUseCase: ActivityUseCase
    private var setActivitiesUseCase: SetActivityUseCase
    
    private var sports: [ActivityModel] = []
    
    init(view: AddSportContract.View, activityUseCase: ActivityUseCase, setActivitiesUseCase: SetActivityUseCase) {
        self.view = view
        self.activityUseCase = activityUseCase
        self.setActivitiesUseCase = setActivitiesUseCase
    }
    
    func create() {
        view.showLoading()
        
        activityUseCase.getAllActivities { (activities, error, errorsMap) in
            self.view.hideLoading()
            
            guard error == nil else {
                self.view.showError()
                return
            }
            
            self.sports = activities ?? []
            self.view.showSports(sports: self.sports)
        }
    }
    
    func saveSports(indexPaths: [IndexPath]?) {
        view.showLoading()
        
        var activities: [String] = []
        
        if let indexPaths = indexPaths {
            for ip in indexPaths {
                activities.append(sports[ip.row].id)
            }
        }
        
        setActivitiesUseCase.setActivities(model: SetActivitiesModel(activities: activities)) { (success, error, errorsMap) in
            
            self.view.hideLoading()
            
            if error != nil {
                var message = String(format: NSLocalizedString("add_sport_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.navigator.popBack()
            }
        }
    }
}
