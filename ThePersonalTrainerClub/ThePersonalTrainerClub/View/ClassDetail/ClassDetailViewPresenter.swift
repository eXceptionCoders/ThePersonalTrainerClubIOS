//
//  ClassDetailViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

class ClassDetailViewPresenter: BaseViewPresenter, ClassDetailContract.Presenter {
    private var view: ClassDetailContract.View
    private var trainerManagementUseCase: TrainerManagementUseCase
    
    init(view: ClassDetailContract.View, trainerManagementUseCase: TrainerManagementUseCase) {
        self.view = view
        self.trainerManagementUseCase = trainerManagementUseCase
    }
    
    func book(_ classId: String) {
        view.showLoading()
        trainerManagementUseCase.book(classId: classId) { (succes, error, errorsMap) in
            
            self.view.hideLoading()
            if error != nil {
                var message = String(format: NSLocalizedString("booking_error", comment: ""))
                
                for (key, detail) in errorsMap ?? [:] {
                    message = String(format: "%@ \n%@: %@", message, key, detail)
                }
                
                self.view.showAlertMessage(title: nil, message: message)
            } else {
                self.view.showAlertMessage(title: nil, message: NSLocalizedString("booking_done", comment: ""))
            }
        }
    }
}
