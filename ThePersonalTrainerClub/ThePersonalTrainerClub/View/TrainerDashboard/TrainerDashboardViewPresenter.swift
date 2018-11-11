//
//  TrainerDashboardViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation


class TrainerDashboardViewPresenter: BaseViewPresenter, TrainerDashboardContract.Presenter {
    private var view: TrainerDashboardContract.View
    
    init(view: TrainerDashboardContract.View) {
        self.view = view
    }
}
