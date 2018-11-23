//
//  TypeSelectionViewPresenter.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 23/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum TypeSelection {
    case trainer
    case client
}

class TypeSelectionViewPresenter: BaseViewPresenter, TypeSelectionContract.Presenter {
    private var view: TypeSelectionContract.View
    private lazy var navigator: TypeSelectionContract.Navigator = TypeSelectionViewNavigator(view: view)
    
    init(view: TypeSelectionContract.View) {
        self.view = view
    }
    
    func onTypeSelected(type: TypeSelection) {
        switch type {
        case .trainer:
            navigator.navigateToTrainerView()
        case .client:
            navigator.navigateToClientView()
        }
    }
}
