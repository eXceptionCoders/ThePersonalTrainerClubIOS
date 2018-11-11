//
//  NewClassViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class NewClassViewController: BaseViewController, NewClassContract.View {

    lazy var presenter: NewClassContract.Presenter = NewClassViewPresenter(view: self, newClassUseCase: NewClassUseCase(newClassProvider: ClassProvider(webService: WebService())))

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Class"
    }
    
    func showLoading() {
        // activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        // activityIndicator.stopAnimating()
    }
}
