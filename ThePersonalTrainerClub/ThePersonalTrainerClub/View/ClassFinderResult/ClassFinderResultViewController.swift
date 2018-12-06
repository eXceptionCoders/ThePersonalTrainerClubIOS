//
//  ClassFinderResultViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassFinderResultViewController: BaseViewController, ClassFinderResultContract.View {

    lazy var presenter: ClassFinderResultContract.Presenter = ClassFinderResultViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func localizeView() {
        
    }
}
