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
        
        activityUseCase.getAllActivities { (activities, error) in
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
        
        var str = ""
        
        if let indexPaths = indexPaths {
            for ip in indexPaths {
                if str.isEmpty {
                    str = "\(sports[ip.row].name)"
                } else {
                    str += ",\(sports[ip.row].name)"
                }
            }
        }
        
        setActivitiesUseCase.setActivities(model: SetActivitiesModel(activities: str)) { (success, error) in
            self.view.hideLoading()
            self.navigator.popBack()
        }
    }
}
