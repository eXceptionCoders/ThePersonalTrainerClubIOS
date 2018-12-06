//
//  ClassDetailViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassDetailViewController: BaseViewController, ClassDetailContract.View {

    lazy var presenter: ClassDetailContract.Presenter = ClassDetailViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func localizeView() {

    }

}
