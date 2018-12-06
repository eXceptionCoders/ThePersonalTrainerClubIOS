//
//  ClassFinderViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassFinderViewController: BaseViewController, ClassFinderContract.View {

    lazy var presenter: ClassFinderContract.Presenter = ClassFinderViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func localizeView() {
        
    }
}
