//
//  ClassDetailViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassDetailViewController: BaseViewController, ClassDetailContract.View {
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - Presenter
    
    lazy var presenter: ClassDetailContract.Presenter = ClassDetailViewPresenter()
    
    // MARK: - Initialization
    
    init() {
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
