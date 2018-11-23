//
//  TypeSelectionViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 23/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum TypeSelectionContract {
    typealias View = TypeSelectionView
    typealias Presenter = TypeSelectionPresenter
    typealias Navigator = TypeSelectionNavigator
}

protocol TypeSelectionView: BaseContract.View {
    
}

protocol TypeSelectionPresenter: BaseContract.Presenter {
    func onTypeSelected(type: TypeSelection)
}

protocol TypeSelectionNavigator: BaseContract.Navigator {
    func navigateToTrainerView()
    func navigateToClientView()
}
