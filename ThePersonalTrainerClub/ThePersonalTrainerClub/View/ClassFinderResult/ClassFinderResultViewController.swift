//
//  ClassFinderResultViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassFinderResultViewController: BaseViewController, ClassFinderResultContract.View {

    // MARK: - Outlets
    
    // MARK: - Properties
    
    var model: ClassFinderQuery
    
    // MARK: - Presenter
    
    lazy var presenter: ClassFinderResultContract.Presenter = ClassFinderResultViewPresenter()
    
    // MARK: - Initialization
    
    init(model: ClassFinderQuery) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - BaseViewController methods
    
    override func localizeView() {
        
    }
}
