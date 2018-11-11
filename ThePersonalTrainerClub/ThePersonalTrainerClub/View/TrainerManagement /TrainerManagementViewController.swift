//
//  TrainerManagementViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TrainerManagementViewController: BaseViewController, TrainerManagementContract.View {
    
    lazy var presenter: TrainerManagementContract.Presenter = TrainerManagementViewPresenter(
        view: self,
        trainerManagementUseCase: TrainerManagementUseCase(
            userProvider: UserProvider(webService: WebService()),
            classProvider: ClassProvider(webService: WebService())
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Management"
    }
    
    func showLoading() {
        // activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        // activityIndicator.stopAnimating()
    }
    
    func setTrainer(_ trainer: UserModel) {
        // TODO
    }
    
    func setClasses(_ classes: [ClassModel]) {
        // TODO
    }
    

}
